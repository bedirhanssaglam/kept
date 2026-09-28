part of '../create_vow_view.dart';

/// Selected ink sits on the lime fill, so the check stays readable.
const _selectedInk = Color(0xFF16301F);

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final ink = selected ? _selectedInk : context.kept.mist;
    return ChoiceChip(
      showCheckmark: false,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected) ...[
            const Icon(Icons.check_rounded, size: 16, color: _selectedInk),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: KeptTheme.accent,
      backgroundColor: context.kept.panel,
      labelStyle: GoogleFonts.manrope(
        color: ink,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: selected ? KeptTheme.accent : context.kept.line,
      ),
    );
  }
}
