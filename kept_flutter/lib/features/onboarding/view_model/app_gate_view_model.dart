import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../data/auth_flow.dart';
import '../data/onboarding_prefs.dart';

enum GateTarget { onboarding, login, username, shell }

final appGateViewModelProvider =
    AutoDisposeAsyncNotifierProvider<AppGateViewModel, GateTarget>(
      AppGateViewModel.new,
    );

class AppGateViewModel extends AutoDisposeAsyncNotifier<GateTarget> {
  @override
  Future<GateTarget> build() async {
    await client.auth.initialize();
    if (client.auth.isAuthenticated) {
      final ready = await hasGlobalUsername();
      return ready ? GateTarget.shell : GateTarget.username;
    }
    if (kIsWeb) return GateTarget.login;
    final done = await isOnboardingDone();
    return done ? GateTarget.login : GateTarget.onboarding;
  }
}
