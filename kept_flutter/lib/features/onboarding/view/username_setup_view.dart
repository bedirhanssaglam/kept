import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../../client.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/init/language/localization.dart';
import '../../shell/view/main_shell.dart';
import '../data/auth_flow.dart';
import 'username_form.dart';

/// Fallback when a signed-in user still has no global username.
class UsernameSetupView extends StatefulWidget {
  const UsernameSetupView({
    super.key,
    this.initialUsername,
    this.errorMessage,
  });

  final String? initialUsername;
  final String? errorMessage;

  @override
  State<UsernameSetupView> createState() => _UsernameSetupViewState();
}

class _UsernameSetupViewState extends State<UsernameSetupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kept.void_,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.kept.wash, context.kept.void_],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'KEPT',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.2,
                    color: KeptTheme.accent,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: UsernameForm(
                      initialUsername: widget.initialUsername,
                      title: context.l10n.chooseUsername,
                      subtitle: context.l10n.usernameSubtitle,
                      onSubmit: (name) async {
                        try {
                          await client.userProfileEdit.changeUserName(name);
                          if (!context.mounted) return;
                          await keptPushReplacement(
                            context,
                            const MainShell(),
                          );
                        } on UsernameException catch (e) {
                          throw e.message;
                        }
                      },
                    ),
                  ),
                ),
                if (widget.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    widget.errorMessage!,
                    style: GoogleFonts.manrope(
                      color: KeptTheme.broke,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
