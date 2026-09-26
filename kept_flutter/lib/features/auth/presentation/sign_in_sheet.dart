import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../../../screens/sign_in_screen.dart';

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
          decoration: const BoxDecoration(
            color: KeptTheme.panel,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(top: BorderSide(color: KeptTheme.line)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: KeptTheme.line,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keep your word',
                      style: GoogleFonts.sora(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.paper,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to join vows, check in daily, and stand with your group.',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: KeptTheme.mist,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SignInScreen(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: KeptTheme.kept,
                          size: 52,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'You’re signed in',
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: KeptTheme.paper,
                          ),
                        ),
                        const SizedBox(height: 22),
                        KeptPrimaryButton(
                          label: 'Continue',
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
