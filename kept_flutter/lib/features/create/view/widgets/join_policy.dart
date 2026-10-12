part of '../create_vow_view.dart';

class _JoinPolicyPicker extends StatelessWidget {
  const _JoinPolicyPicker({
    required this.policies,
    required this.selected,
    required this.onChanged,
  });

  final List<_LabeledValue<String>> policies;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final help = policies
        .firstWhere((policy) => policy.value == selected)
        .help!;

    if (keptUsesNativeCupertino) {
      final selectedIndex = policies.indexWhere(
        (policy) => policy.value == selected,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
            width: double.infinity,
            child: CNSegmentedControl(
              labels: [for (final policy in policies) policy.label],
              selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
              height: 36,
              color: KeptTheme.accent,
              onValueChanged: (index) {
                if (index < 0 || index >= policies.length) return;
                onChanged(policies[index].value);
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            help,
            style: GoogleFonts.manrope(fontSize: 12, color: context.kept.mist),
          ),
        ],
      );
    }

    return Column(
      children: [
        for (final policy in policies)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _PolicyTile(
              label: policy.label,
              help: policy.help ?? '',
              selected: selected == policy.value,
              onTap: () => onChanged(policy.value),
            ),
          ),
      ],
    );
  }
}

class _PolicyTile extends StatelessWidget {
  const _PolicyTile({
    required this.label,
    required this.help,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String help;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.kept.panel,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? KeptTheme.accent.withValues(alpha: 0.55)
                  : context.kept.line,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? KeptTheme.accent : context.kept.mist,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                    Text(
                      help,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: context.kept.mist,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
