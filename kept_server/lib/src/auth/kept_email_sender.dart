import 'dart:async';

import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';

/// Sends Kept auth verification emails over SMTP.
///
/// Expects these keys in `config/passwords.yaml` (or `SERVERPOD_PASSWORD_*`):
/// - `smtpHost` (e.g. `smtp.gmail.com`, `smtp.resend.com`)
/// - `smtpPort` (usually `587`)
/// - `smtpUsername`
/// - `smtpPassword`
/// - `smtpFromEmail`
/// - `smtpFromName` (optional, defaults to Kept)
Future<void> sendKeptVerificationEmail(
  Session session, {
  required String toEmail,
  required String subject,
  required String verificationCode,
}) async {
  final passwords = session.passwords;
  final host = passwords['smtpHost'];
  final username = passwords['smtpUsername'];
  final password = passwords['smtpPassword'];
  final fromEmail = passwords['smtpFromEmail'];
  final fromName = passwords['smtpFromName'] ?? 'Kept';
  final port = int.tryParse(passwords['smtpPort'] ?? '') ?? 587;

  if (host == null ||
      host.isEmpty ||
      username == null ||
      username.isEmpty ||
      password == null ||
      password.isEmpty ||
      fromEmail == null ||
      fromEmail.isEmpty) {
    session.log(
      'SMTP not configured in passwords.yaml — '
      'verification code for $toEmail: $verificationCode',
      level: LogLevel.warning,
    );
    return;
  }

  final smtpServer = SmtpServer(
    host,
    port: port,
    username: username,
    password: password,
    ssl: port == 465,
    allowInsecure: false,
  );

  final message = mailer.Message()
    ..from = mailer.Address(fromEmail, fromName)
    ..recipients.add(toEmail)
    ..subject = subject
    ..text =
        'Your Kept verification code is: $verificationCode\n\n'
        'It expires in 15 minutes. If you did not request this, ignore the email.'
    ..html =
        '<p>Your Kept verification code is:</p>'
        '<p style="font-size:28px;font-weight:700;letter-spacing:4px;">'
        '$verificationCode</p>'
        '<p>It expires in 15 minutes. If you did not request this, ignore the email.</p>';

  try {
    // Cloud / blocked SMTP hosts can hang past the Flutter client timeout
    // (~20s). Fail fast so registration still completes and the code is logged.
    final report = await mailer
        .send(message, smtpServer)
        .timeout(const Duration(seconds: 8));
    session.log('Verification email sent to $toEmail ($report)');
  } on TimeoutException catch (e) {
    session.log(
      'SMTP timed out sending to $toEmail: $e',
      level: LogLevel.error,
    );
    session.log(
      'Verification code for $toEmail: $verificationCode',
      level: LogLevel.warning,
    );
  } on mailer.MailerException catch (e) {
    session.log(
      'Failed to send verification email to $toEmail: $e',
      level: LogLevel.error,
    );
    // Still surface the code in logs so local debugging is not blocked.
    session.log(
      'Verification code for $toEmail: $verificationCode',
      level: LogLevel.warning,
    );
  }
}
