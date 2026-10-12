import 'package:flutter/material.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

class SignInView extends StatefulWidget {
  final Widget child;
  const SignInView({super.key, required this.child});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final EmailAuthController _email;
  bool _isSignedIn = false;
  Object? _lastShownError;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
    _email = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.startRegistration,
      onAuthenticated: _onAuthenticated,
      onError: _showError,
    )..addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    _email
      ..removeListener(_onEmailChanged)
      ..dispose();
    super.dispose();
  }

  void _onAuthenticated() {
    if (!mounted) return;
    final colors = Theme.of(context).colorScheme;
    _showSnackBar(
      message: LocaleKeys.signedIn.tr(),
      backgroundColor: colors.primaryContainer,
      foregroundColor: colors.onPrimaryContainer,
    );
  }

  /// Serverpod hides this case by default. The server throws it, the stock
  /// widget never surfaces it, and Continue stays disabled while the flow
  /// sits in the error state.
  void _onEmailChanged() {
    final error = _email.error;
    if (error is! EmailAlreadyRegisteredException) return;
    if (identical(error, _lastShownError)) return;
    _lastShownError = error;
    final message = error.message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _email.navigateTo(EmailFlowScreen.login);
      _showError(EmailAlreadyRegisteredException(message: message));
    });
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
    });
  }

  void _showError(Object error) {
    if (!mounted) return;
    final colors = Theme.of(context).colorScheme;
    final message = switch (error) {
      EmailAlreadyRegisteredException(:final message) => message,
      final other => LocaleKeys.authFailed.tr(namedArgs: {'error': '$other'}),
    };
    _showSnackBar(
      message: message,
      backgroundColor: colors.errorContainer,
      foregroundColor: colors.onErrorContainer,
    );
  }

  void _showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn
        ? widget.child
        : SignInWidget(
            client: client,
            disableAnonymousSignInWidget: true,
            emailSignInWidget: EmailSignInWidget(controller: _email),
            onAuthenticated: _onAuthenticated,
            onError: _showError,
          );
  }
}
