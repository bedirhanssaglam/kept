import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../data/auth_flow.dart';
import '../data/onboarding_prefs.dart';

enum GateTarget { onboarding, login, username, shell }

class AppGateViewModel extends AutoDisposeAsyncNotifier<GateTarget> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<AppGateViewModel, GateTarget>(
        AppGateViewModel.new,
      );
  @override
  Future<GateTarget> build() async {
    await client.auth.initialize();
    if (client.auth.isAuthenticated) {
      final ready = await const AuthFlow().hasUsername();
      return ready ? GateTarget.shell : GateTarget.username;
    }
    if (kIsWeb) return GateTarget.login;
    final done = await const OnboardingPrefs().isDone();
    return done ? GateTarget.login : GateTarget.onboarding;
  }
}
