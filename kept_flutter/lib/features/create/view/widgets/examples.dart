part of '../create_vow_view.dart';

class _VowDraft {
  const _VowDraft(this.title, this.rule, this.category);

  final String title;
  final String rule;
  final String category;
}

List<_VowDraft> _drafts() => [
  _VowDraft(
    LocaleKeys.exampleWaterTitle.tr(),
    LocaleKeys.exampleWaterRule.tr(),
    VowCategory.health,
  ),
  _VowDraft(
    LocaleKeys.examplePhoneTitle.tr(),
    LocaleKeys.examplePhoneRule.tr(),
    VowCategory.quit,
  ),
  _VowDraft(LocaleKeys.exampleWalkTitle.tr(), LocaleKeys.exampleWalkRule.tr(), VowCategory.move),
];

class _ExampleList extends StatelessWidget {
  const _ExampleList({required this.selected, required this.onSelect});

  final int? selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final drafts = _drafts();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.examplesLead.tr(),
          style: GoogleFonts.manrope(color: context.kept.mist),
        ),
        const SizedBox(height: 10),
        for (var i = 0; i < drafts.length; i++) ...[
          _ExampleRow(
            title: drafts[i].title,
            rule: drafts[i].rule,
            selected: selected == i,
            onTap: () => onSelect(i),
          ),
          if (i != drafts.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({
    required this.title,
    required this.rule,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String rule;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? KeptTheme.accent.withValues(alpha: 0.16)
                : context.kept.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? KeptTheme.accent : context.kept.line,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.check_rounded : Icons.edit_outlined,
                size: 18,
                color: selected ? _selectedInk : context.kept.mist,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rule,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        height: 1.35,
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
