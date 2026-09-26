import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import 'username_rules.dart';

/// Exposes profile editing (username, full name, image) to the Flutter app.
class UserProfileEditEndpoint extends UserProfileEditBaseEndpoint {
  @override
  Future<UserProfileModel> changeUserName(
    Session session,
    String? userName,
  ) async {
    final raw = UsernameRules.normalize(userName);
    await UsernameRules.assertAvailable(
      session,
      raw,
      exceptAuthUserId: session.authenticated!.authUserId,
    );
    return super.changeUserName(session, raw);
  }
}
