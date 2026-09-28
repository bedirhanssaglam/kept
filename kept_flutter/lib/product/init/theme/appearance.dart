import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'kept_theme_mode';

final appearanceProvider = NotifierProvider<AppearanceNotifier, ThemeMode>(
  AppearanceNotifier.new,
);

class AppearanceNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final stored = appearancePrefs?.getString(_themeKey);
    return stored == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> use(ThemeMode mode) async {
    state = mode;
    await appearancePrefs?.setString(
      _themeKey,
      mode == ThemeMode.light ? 'light' : 'dark',
    );
  }
}

SharedPreferences? appearancePrefs;

Future<void> loadAppearancePrefs() async {
  appearancePrefs = await SharedPreferences.getInstance();
}
