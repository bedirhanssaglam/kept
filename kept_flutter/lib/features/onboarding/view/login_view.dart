import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/theme/kept_theme.dart';
import '../../shell/view/main_shell.dart';
import '../data/auth_flow.dart';
import 'username_form.dart';
import 'username_setup_view.dart';

/// Email sign-in / register. After the verification code succeeds, asks for a
/// username before the password step, then saves it once the session exists.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    // Live email validation is shown inline on the field. Auth failures go
    // through [onError]. Only custom server exceptions (not converted by the
    // IDP package) need a snackbar from this listener.
    final error = _controller.error;
    if (error is! EmailAlreadyRegisteredException) return;
    if (identical(error, _lastShownError)) return;
    _lastShownError = error;
    _showError(error);
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
          UsernameSetupView(
            initialUsername: pending,
            errorMessage: e.message,
          ),
        );
        return;
      } catch (e) {
        if (!mounted) return;
        setState(() => _savingUsername = false);
        await keptPushReplacement(
          context,
          UsernameSetupView(initialUsername: pending, errorMessage: '$e'),
        );
        return;
      }
    }

    if (!mounted) return;
    await keptPushReplacement(context, const MainShell());
  }

  void _showError(Object error) {
    if (!mounted) return;
    final message = switch (error) {
      EmailAlreadyRegisteredException(:final message) => message,
      final e => '$e',
    };
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: KeptTheme.broke,
          duration: const Duration(seconds: 5),
        ),
      );
  }

  bool get _showUsernameStep => _controller.currentScreen == EmailFlowScreen.completeRegistration && _pendingUsername == null;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: 56,
                      height: 56,
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'kept',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.2,
                        color: KeptTheme.accent,
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
                        fillColor: context.kept.ink,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: context.kept.line),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: context.kept.line),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: KeptTheme.accent),
                        ),
                        labelStyle: GoogleFonts.manrope(
                          color: context.kept.mist,
                        ),
                        hintStyle: GoogleFonts.manrope(
                          color: context.kept.mist,
                        ),
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
