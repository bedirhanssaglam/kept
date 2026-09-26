import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../shell/presentation/main_shell.dart';
import '../data/auth_flow.dart';
import '../data/onboarding_prefs.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';
import 'username_setup_screen.dart';

/// Mobile: onboarding → email login → username → app.
/// Authenticated without username → username setup.
/// Otherwise → [MainShell].
class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  late final Future<_GateTarget> _future;

  @override
  void initState() {
    super.initState();
    _future = _resolve();
  }

  Future<_GateTarget> _resolve() async {
    await client.auth.initialize();

    if (client.auth.isAuthenticated) {
      final ready = await hasGlobalUsername();
      return ready ? _GateTarget.shell : _GateTarget.username;
    }

    // Web skips marketing onboarding; still needs sign-in / username.
    if (kIsWeb) {
      return _GateTarget.login;
    }

    final done = await isOnboardingDone();
    return done ? _GateTarget.login : _GateTarget.onboarding;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_GateTarget>(
      future: _future,
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return switch (snap.data!) {
          _GateTarget.onboarding => const OnboardingScreen(),
          _GateTarget.login => const LoginScreen(),
          _GateTarget.username => const UsernameSetupScreen(),
          _GateTarget.shell => const MainShell(),
        };
      },
    );
  }
}

enum _GateTarget { onboarding, login, username, shell }
