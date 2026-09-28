import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/components/async_data_widget.dart';
import '../../shell/view/main_shell.dart';
import '../view_model/app_gate_view_model.dart';
import 'login_view.dart';
import 'onboarding_view.dart';
import 'username_setup_view.dart';

/// Mobile: onboarding → email login → username → app.
/// Authenticated without username → username setup.
/// Otherwise → [MainShell].
class AppGate extends ConsumerWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncDataWidget<GateTarget>(
      asyncValue: ref.watch(appGateViewModelProvider),
      onData: (target) {
        return switch (target) {
          GateTarget.onboarding || null => const OnboardingView(),
          GateTarget.login => const LoginView(),
          GateTarget.username => const UsernameSetupView(),
          GateTarget.shell => const MainShell(),
        };
      },
    );
  }
}
