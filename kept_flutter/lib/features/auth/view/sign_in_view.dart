import 'package:flutter/material.dart';
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
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _isSignedIn
        ? widget.child
        : Center(
            child: SignInWidget(
              client: client,
              disableAnonymousSignInWidget: true,
              onAuthenticated: () {
                context.showSnackBar(
                  message: LocaleKeys.signedIn.tr(),
                  backgroundColor: colors.primaryContainer,
                  foregroundColor: colors.onPrimaryContainer,
                );
              },
              onError: (error) {
                context.showSnackBar(
                  message: LocaleKeys.authFailed.tr(namedArgs: {'error': '$error'}),
                  backgroundColor: colors.errorContainer,
                  foregroundColor: colors.onErrorContainer,
                );
              },
            ),
          );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
