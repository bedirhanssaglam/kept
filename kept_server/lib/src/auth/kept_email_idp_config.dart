import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// Password key injected by Serverpod Cloud for the hosted email service.
const _scloudAuthEmailKey = 'scloudAuthEmailKey';

/// Email IDP that always logs the verification code, then tries Serverpod Cloud
/// email in staging/production. Development/test only logs (no HTTP send).
EmailIdpConfig keptEmailIdpConfig({String appDisplayName = 'Kept'}) {
  final runMode = Serverpod.instance.runMode;
  final isDev =
      runMode == ServerpodRunMode.development ||
      runMode == ServerpodRunMode.test;
  final client = isDev ? null : ServerpodCloudEmailClient();

  Future<void> send({
    required Session session,
    required String email,
    required String code,
    required ServerpodCloudEmailType emailType,
    required String label,
  }) async {
    // Always log so we can recover the code from `scloud log` when mail
    // is delayed, filtered, or the Cloud send fails silently.
    session.log(
      '$label verification code for $email: $code',
      level: LogLevel.info,
    );

    if (client == null) {
      session.alert('$label code for $email: <$code>');
      return;
    }

    final token = Serverpod.instance.getPassword(_scloudAuthEmailKey);
    if (token == null || token.isEmpty) {
      session.log(
        'Missing $_scloudAuthEmailKey — $label email not sent to $email',
        level: LogLevel.error,
      );
      return;
    }

    try {
      await client.sendEmail(
        token: token,
        emailType: emailType,
        email: email,
        projectName: appDisplayName,
        authCode: code,
      );
      session.log('$label email sent to $email via Serverpod Cloud');
    } catch (e, stackTrace) {
      session.log(
        'Failed to send $label email via Serverpod Cloud for $email',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  return EmailIdpConfigFromPasswords(
    sendRegistrationVerificationCode:
        (
          session, {
          required email,
          required accountRequestId,
          required verificationCode,
          required transaction,
        }) => send(
          session: session,
          email: email,
          code: verificationCode,
          emailType: ServerpodCloudEmailType.signup,
          label: 'Registration',
        ),
    sendPasswordResetVerificationCode:
        (
          session, {
          required email,
          required passwordResetRequestId,
          required verificationCode,
          required transaction,
        }) => send(
          session: session,
          email: email,
          code: verificationCode,
          emailType: ServerpodCloudEmailType.lostpassword,
          label: 'Password reset',
        ),
  );
}
