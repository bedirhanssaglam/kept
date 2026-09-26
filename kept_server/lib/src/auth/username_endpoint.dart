import 'package:serverpod/serverpod.dart';

import 'username_rules.dart';

/// Public username helpers (available before the user finishes registration).
class UsernameEndpoint extends Endpoint {
  /// Validates format and uniqueness. Throws [UsernameException] on failure.
  Future<void> assertAvailable(Session session, String userName) async {
    final raw = UsernameRules.normalize(userName);
    await UsernameRules.assertAvailable(session, raw);
  }
}
