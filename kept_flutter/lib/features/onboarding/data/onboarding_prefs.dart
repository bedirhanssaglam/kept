import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPrefs {
  const OnboardingPrefs();

  static const _doneKey = 'kept_onboarding_done_v1';

  Future<bool> isDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_doneKey) ?? false;
  }

  Future<void> markDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_doneKey, true);
  }
}
