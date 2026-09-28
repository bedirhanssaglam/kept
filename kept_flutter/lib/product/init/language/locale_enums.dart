import 'package:flutter/widgets.dart';

enum LocaleEnums {
  en(Locale('en')),
  tr(Locale('tr'));

  const LocaleEnums(this.locale);

  final Locale locale;

  static const supported = [Locale('en'), Locale('tr')];
}
