import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../shell/view/main_shell.dart';
import '../view/username_setup_view.dart';

/// Shared fade navigation used by onboarding / auth gates.
Future<void> keptPushReplacement(BuildContext context, Widget page) {
  return Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 380),
    ),
  );
}

/// True when the signed-in user already has a global username.
Future<bool> hasGlobalUsername() async {
  if (!client.auth.isAuthenticated) return false;
  try {
    final profile = await client.modules.serverpod_auth_core.userProfileInfo
        .get();
    final name = profile.userName?.trim();
    return name != null && name.isNotEmpty;
  } catch (_) {
    return false;
  }
}

/// After auth: username setup if needed, otherwise [MainShell].
Future<void> enterKeptApp(BuildContext context) async {
  if (!context.mounted) return;
  final ready = await hasGlobalUsername();
  if (!context.mounted) return;
  await keptPushReplacement(
    context,
    ready ? const MainShell() : const UsernameSetupView(),
  );
}

/// Instagram-style usernames, matching the server rules.
bool isKeptUsernameValid(String raw) {
  final value = raw.trim().toLowerCase();
  return RegExp(r'^[a-z][a-z0-9_]{2,29}$').hasMatch(value);
}
