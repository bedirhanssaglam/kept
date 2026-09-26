import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../core/theme/kept_theme.dart';
import '../../shell/presentation/main_shell.dart';
import '../data/auth_flow.dart';
import 'username_form.dart';
import 'username_setup_screen.dart';

/// Email sign-in / register. After the verification code succeeds, asks for a
/// username before the password step, then saves it once the session exists.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final EmailAuthController _controller;
  Object? _lastShownError;
  String? _pendingUsername;
  bool _savingUsername = false;

  @override
  void initState() {
    super.initState();
    _controller = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.login,
      onAuthenticated: _onAuthenticated,
      onError: _showError,
    )..addListener(_onControllerChanged);

    if (client.auth.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        enterKeptApp(context);
      });
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    // Leaving the post-code step clears a half-chosen username.
    if (_controller.currentScreen != EmailFlowScreen.completeRegistration &&
        _controller.currentScreen != EmailFlowScreen.verifyRegistration) {
      // Keep pending username only through password completion.
    }

    final error = _controller.error;
    if (error == null || identical(error, _lastShownError)) return;
    if (error is EmailAlreadyRegisteredException) {
      _lastShownError = error;
      _showError(error);
    }
    setState(() {});
  }

  Future<void> _onAuthenticated() async {
    final pending = _pendingUsername;
    if (pending != null && pending.isNotEmpty) {
      setState(() => _savingUsername = true);
      try {
        await client.userProfileEdit.changeUserName(pending);
      } on UsernameException catch (e) {
        if (!mounted) return;
        setState(() => _savingUsername = false);
        await keptPushReplacement(
          context,
          UsernameSetupScreen(initialUsername: pending, errorMessage: e.message),
        );
        return;
      } catch (e) {
        if (!mounted) return;
        setState(() => _savingUsername = false);
        await keptPushReplacement(
          context,
          UsernameSetupScreen(initialUsername: pending, errorMessage: '$e'),
        );
        return;
      }
    }

    if (!mounted) return;
    await keptPushReplacement(context, const MainShell());
  }

  void _showError(Object error) {
    if (!mounted) return;
    final message = error is EmailAlreadyRegisteredException
        ? error.message
        : '$error';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: KeptTheme.broke,
      ),
    );
  }

  bool get _showUsernameStep =>
      _controller.currentScreen == EmailFlowScreen.completeRegistration &&
      _pendingUsername == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KeptTheme.void_,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF152019), KeptTheme.void_],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 14),
                    Text(
                      _showUsernameStep
                          ? 'Almost there'
                          : 'Sign in to keep your word',
                      style: GoogleFonts.sora(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        letterSpacing: -0.7,
                        color: KeptTheme.paper,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _showUsernameStep
                          ? 'Email verified. Pick your username, then set a password.'
                          : 'Email and password. We’ll send a verification code to your inbox.',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        height: 1.45,
                        color: KeptTheme.mist,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
                  child: Theme(
                    data: KeptTheme.dark().copyWith(
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: KeptTheme.ink,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: KeptTheme.line),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: KeptTheme.line),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: KeptTheme.accent),
                        ),
                        labelStyle: GoogleFonts.manrope(color: KeptTheme.mist),
                        hintStyle: GoogleFonts.manrope(color: KeptTheme.mist),
                      ),
                    ),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        if (_savingUsername) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 48),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        }
                        if (_showUsernameStep) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: UsernameForm(
                              onSubmit: (name) async {
                                try {
                                  await client.username.assertAvailable(name);
                                } on UsernameException catch (e) {
                                  throw e.message;
                                }
                                if (!mounted) return;
                                setState(() => _pendingUsername = name);
                              },
                            ),
                          );
                        }
                        return EmailSignInWidget(controller: _controller);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
