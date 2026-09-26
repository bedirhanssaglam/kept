import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  /// Starts registration, but surfaces an explicit error when the email is
  /// already taken (Serverpod's default silently returns a dummy request id).
  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    final normalized = email.trim().toLowerCase();
    final existing = await emailIdp.admin.findAccount(
      session,
      email: normalized,
    );
    if (existing != null) {
      throw EmailAlreadyRegisteredException(
        message: 'This email is already registered. Sign in instead.',
      );
    }
    return super.startRegistration(session, email: normalized);
  }
}
