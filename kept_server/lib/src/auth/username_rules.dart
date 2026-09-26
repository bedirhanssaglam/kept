import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Shared username format + uniqueness checks.
abstract final class UsernameRules {
  static final pattern = RegExp(r'^[a-z][a-z0-9_]{2,29}$');

  static String normalize(String? userName) =>
      userName?.trim().toLowerCase() ?? '';

  static void assertFormat(String raw) {
    if (!pattern.hasMatch(raw)) {
      throw UsernameException(
        message:
            'Use 3–30 characters: start with a letter, then letters, numbers, or _.',
      );
    }
  }

  /// Throws [UsernameException] if [raw] is taken by someone other than [exceptAuthUserId].
  static Future<void> assertAvailable(
    Session session,
    String raw, {
    UuidValue? exceptAuthUserId,
  }) async {
    assertFormat(raw);
    final taken = await AuthServices.instance.userProfiles.admin.listUserProfiles(
      session,
      userName: raw,
      limit: 5,
    );
    final conflict = taken.any(
      (p) => exceptAuthUserId == null || p.authUserId != exceptAuthUserId,
    );
    if (conflict) {
      throw UsernameException(message: 'That username is taken.');
    }
  }
}
