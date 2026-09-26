import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../layout/kept_breakpoints.dart';
import '../theme/kept_theme.dart';
import 'kept_native.dart';

/// Share of people who have spoken today that kept the vow.
/// Null when nobody has checked in yet.
int? keptSharePercent({required int kept, required int broken}) {
  final spoken = kept + broken;
  if (spoken == 0) return null;
  return ((kept * 100) / spoken).round();
}

class CategoryStyle {
  const CategoryStyle(this.label, this.color);

  final String label;
  final Color color;

  static CategoryStyle of(String category) {
    switch (category) {
      case 'health':
        return const CategoryStyle('Health', Color(0xFF5EEAD4));
      case 'quit':
        return const CategoryStyle('Quit', Color(0xFFFF9B8A));
      case 'move':
        return const CategoryStyle('Move', Color(0xFF93C5FD));
      case 'focus':
        return const CategoryStyle('Focus', Color(0xFFFDE68A));
      default:
        return const CategoryStyle('Custom', KeptTheme.mist);
    }
  }
}

class KeptChip extends StatelessWidget {
  const KeptChip({
    super.key,
    required this.label,
    this.color = KeptTheme.mist,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class KeptPrimaryButton extends StatelessWidget {
  const KeptPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  static const _wideMaxWidth = 320.0;

  @override
  Widget build(BuildContext context) {
    final wide =
        MediaQuery.sizeOf(context).width >= KeptBreakpoints.compact;

    Widget sized(Widget child) {
      if (!expanded) return child;
      if (wide) {
        return Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: _wideMaxWidth,
              minWidth: 200,
            ),
            child: SizedBox(width: double.infinity, height: 48, child: child),
          ),
        );
      }
      return SizedBox(width: double.infinity, height: 48, child: child);
    }

    if (keptUsesNativeCupertino) {
      return sized(
        CNButton(
          label: label,
          onPressed: onPressed,
          enabled: onPressed != null,
          tint: KeptTheme.ink,
          height: 48,
          shrinkWrap: !expanded,
          style: CNButtonStyle.prominentGlass,
        ),
      );
    }

    final child = FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: KeptTheme.accent,
        foregroundColor: KeptTheme.void_,
        disabledBackgroundColor: KeptTheme.line,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.sora(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      child: Text(label),
    );
    return sized(child);
  }
}
