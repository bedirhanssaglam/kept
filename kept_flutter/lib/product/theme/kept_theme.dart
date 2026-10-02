import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// Surfaces that change between light and dark.
class KeptPalette extends ThemeExtension<KeptPalette> {
  const KeptPalette({
    required this.void_,
    required this.ink,
    required this.panel,
    required this.line,
    required this.mist,
    required this.paper,
    required this.wash,
  });

  final Color void_;
  final Color ink;
  final Color panel;
  final Color line;
  final Color mist;
  final Color paper;
  final Color wash;

  static const dark = KeptPalette(
    void_: Color(0xFF0A0F0D),
    ink: Color(0xFF101714),
    panel: Color(0xFF17201C),
    line: Color(0xFF2A3831),
    mist: Color(0xFF8FA399),
    paper: Color(0xFFE8F0EA),
    wash: Color(0xFF152019),
  );

  static const light = KeptPalette(
    void_: Color(0xFFF3F6F4),
    ink: Color(0xFFFFFFFF),
    panel: Color(0xFFFFFFFF),
    line: Color(0xFFD5E0DA),
    mist: Color(0xFF5C6E65),
    paper: Color(0xFF122019),
    wash: Color(0xFFE3F0E7),
  );

  @override
  KeptPalette copyWith({
    Color? void_,
    Color? ink,
    Color? panel,
    Color? line,
    Color? mist,
    Color? paper,
    Color? wash,
  }) {
    return KeptPalette(
      void_: void_ ?? this.void_,
      ink: ink ?? this.ink,
      panel: panel ?? this.panel,
      line: line ?? this.line,
      mist: mist ?? this.mist,
      paper: paper ?? this.paper,
      wash: wash ?? this.wash,
    );
  }

  @override
  KeptPalette lerp(ThemeExtension<KeptPalette>? other, double t) {
    if (other is! KeptPalette) return this;
    return KeptPalette(
      void_: Color.lerp(void_, other.void_, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      panel: Color.lerp(panel, other.panel, t)!,
      line: Color.lerp(line, other.line, t)!,
      mist: Color.lerp(mist, other.mist, t)!,
      paper: Color.lerp(paper, other.paper, t)!,
      wash: Color.lerp(wash, other.wash, t)!,
    );
  }
}

extension KeptPaletteContext on BuildContext {
  KeptPalette get kept =>
      Theme.of(this).extension<KeptPalette>() ?? KeptPalette.dark;
}

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

  static ThemeData light() => _theme(Brightness.light, KeptPalette.light);

  static ThemeData dark() => _theme(Brightness.dark, KeptPalette.dark);

  static ThemeData _theme(Brightness brightness, KeptPalette palette) {
    final display = GoogleFonts.soraTextTheme();
    final body = GoogleFonts.manropeTextTheme();
    final onSurface = palette.paper;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: accent,
      onPrimary: brightness == Brightness.dark ? palette.void_ : Colors.white,
      secondary: kept,
      onSecondary: palette.void_,
      error: broke,
      onError: Colors.white,
      surface: palette.ink,
      onSurface: onSurface,
    );

    final pinText = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: palette.paper,
      height: 1.1,
    );
    final pinDecoration = BoxDecoration(
      color: palette.panel,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: palette.line),
    );
    final authIdpTheme = AuthIdpTheme.defaultTheme(
      borderColor: accent,
      defaultPinTheme: PinTheme(
        height: 48,
        textStyle: pinText,
        decoration: pinDecoration,
      ),
      focusedPinTheme: PinTheme(
        height: 48,
        textStyle: pinText,
        decoration: pinDecoration.copyWith(
          border: Border.all(color: accent, width: 1.5),
        ),
      ),
      errorPinTheme: PinTheme(
        height: 48,
        textStyle: pinText.copyWith(color: Colors.white),
        decoration: BoxDecoration(
          color: broke,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: palette.void_,
      colorScheme: scheme,
      extensions: [palette, authIdpTheme],
      textTheme: body.copyWith(
        displayLarge: display.displayLarge?.copyWith(
          color: palette.paper,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.2,
        ),
        headlineLarge: display.headlineLarge?.copyWith(
          color: palette.paper,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        headlineMedium: display.headlineMedium?.copyWith(
          color: palette.paper,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: display.titleLarge?.copyWith(
          color: palette.paper,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: body.titleMedium?.copyWith(
          color: palette.paper,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: body.bodyLarge?.copyWith(color: palette.paper, height: 1.4),
        bodyMedium: body.bodyMedium?.copyWith(color: palette.mist, height: 1.4),
        bodySmall: body.bodySmall?.copyWith(color: palette.mist),
        labelLarge: body.labelLarge?.copyWith(
          color: palette.paper,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
