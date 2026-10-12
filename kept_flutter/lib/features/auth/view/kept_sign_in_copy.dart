import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../product/init/language/locale_keys.g.dart';

/// Kept copy for the email auth screens, including the spam-folder hint.
///
/// The code boxes size themselves from the available width. On a wide web
/// window that makes them taller than the auth form, so the title and the
/// button collide. [maxWidth] keeps each box about a fingertip wide.
class KeptSignInCopy extends StatelessWidget {
  const KeptSignInCopy({super.key, required this.child});

  static const maxWidth = 440.0;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: SignInLocalizationProvider(
          email: EmailSignInTexts.defaults.copyWith(
            verificationMessage: LocaleKeys.verificationMessage.tr(),
          ),
          child: child,
        ),
      ),
    );
  }
}
