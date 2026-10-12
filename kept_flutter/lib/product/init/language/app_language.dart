import 'package:flutter/material.dart';

/// Languages the app ships. Wire codes stay on the enum, not in call sites.
enum AppLanguage {
  en('en');

  const AppLanguage(this.languageCode);

  final String languageCode;

  Locale get locale => Locale(languageCode);

  static const supported = <AppLanguage>[AppLanguage.en];

  static const fallback = AppLanguage.en;

  static const translationsPath = 'assets/translations';

  static List<Locale> get locales => [
    for (final language in supported) language.locale,
  ];
}
