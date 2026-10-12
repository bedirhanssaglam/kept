import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceStore {
  static final provider = Provider<AppearanceStore>(
    (ref) => throw StateError('AppearanceStore is provided at startup.'),
  );

  AppearanceStore(this._prefs);

  static const _key = 'kept_theme_mode';

  final SharedPreferences _prefs;

  static Future<AppearanceStore> load() async {
    return AppearanceStore(await SharedPreferences.getInstance());
  }

  ThemeMode read() {
    final stored = _prefs.getString(_key);
    return ThemeMode.values.asNameMap()[stored] ?? ThemeMode.dark;
  }

  Future<void> write(ThemeMode mode) {
    return _prefs.setString(_key, mode.name);
  }
}

class AppearanceNotifier extends Notifier<ThemeMode> {
  static final provider = NotifierProvider<AppearanceNotifier, ThemeMode>(
    AppearanceNotifier.new,
  );

  @override
  ThemeMode build() => ref.read(AppearanceStore.provider).read();

  Future<void> use(ThemeMode mode) async {
    state = mode;
    await ref.read(AppearanceStore.provider).write(mode);
  }
}
