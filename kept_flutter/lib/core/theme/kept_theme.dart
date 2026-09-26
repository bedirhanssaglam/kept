import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Kept — calm accountability, not noisy social.
abstract final class KeptTheme {
  static const void_ = Color(0xFF0A0F0D);
  static const ink = Color(0xFF101714);
  static const panel = Color(0xFF17201C);
  static const line = Color(0xFF2A3831);
  static const mist = Color(0xFF8FA399);
  static const paper = Color(0xFFE8F0EA);
  static const kept = Color(0xFF3DDC97);
  static const keptDim = Color(0x1F3DDC97);
  static const broke = Color(0xFFFF7A6E);
  static const brokeDim = Color(0x1FFF7A6E);
  static const pending = Color(0xFFD6B25E);
  /// Slightly deeper lime so white labels on native tinted controls stay readable.
  static const accent = Color(0xFF8FD45C);

  static ThemeData dark() {
    final display = GoogleFonts.soraTextTheme();
    final body = GoogleFonts.manropeTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: void_,
      colorScheme: const ColorScheme.dark(
        surface: ink,
        primary: accent,
        onPrimary: void_,
        secondary: kept,
        error: broke,
      ),
      textTheme: body.copyWith(
        displayLarge: display.displayLarge?.copyWith(
          color: paper,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.2,
        ),
        headlineLarge: display.headlineLarge?.copyWith(
          color: paper,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        headlineMedium: display.headlineMedium?.copyWith(
          color: paper,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: display.titleLarge?.copyWith(
          color: paper,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: body.titleMedium?.copyWith(
          color: paper,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: body.bodyLarge?.copyWith(color: paper, height: 1.4),
        bodyMedium: body.bodyMedium?.copyWith(color: mist, height: 1.4),
        bodySmall: body.bodySmall?.copyWith(color: mist),
        labelLarge: body.labelLarge?.copyWith(
          color: paper,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
