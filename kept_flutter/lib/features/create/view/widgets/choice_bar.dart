part of '../create_vow_view.dart';

class _ChoiceBar extends StatelessWidget {
  const _ChoiceBar({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    if (keptUsesNativeCupertino) {
      return SizedBox(
        height: 36,
        width: double.infinity,
        child: CNSegmentedControl(
          labels: labels,
          selectedIndex: selectedIndex,
          height: 36,
          color: KeptTheme.accent,
          onValueChanged: onChanged,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < labels.length; i++)
          _CategoryChip(
            label: labels[i],
            selected: selectedIndex == i,
            onSelected: () => onChanged(i),
          ),
      ],
    );
  }
}
