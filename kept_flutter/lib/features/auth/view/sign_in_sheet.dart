import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/components/kept_widgets.dart';
import '../../../product/init/language/localization.dart';
import 'sign_in_view.dart';

Future<bool> showSignInSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.78,
          decoration: BoxDecoration(
            color: context.kept.panel,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(top: BorderSide(color: context.kept.line)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.kept.line,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.keepYourWord,
                      style: GoogleFonts.sora(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.signInSheetBody,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: context.kept.mist,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SignInView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: KeptTheme.kept,
                          size: 52,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          context.l10n.signedIn,
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: context.kept.paper,
                          ),
                        ),
                        const SizedBox(height: 22),
                        KeptPrimaryButton(
                          label: context.l10n.continueAction,
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  return result == true || client.auth.isAuthenticated;
}
