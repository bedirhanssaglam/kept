/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Membership of a user in a vow room.
abstract class VowMembership
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VowMembership._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.displayName,
    String? role,
    required this.joinedAt,
  }) : role = role ?? 'member';

  factory VowMembership({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    String? role,
    required DateTime joinedAt,
  }) = _VowMembershipImpl;

  factory VowMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowMembership(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      role: jsonSerialization['role'] as String?,
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  String userId;

  /// Public label shown on the board.
  String displayName;

  /// owner | admin | member
  String role;

  DateTime joinedAt;

  /// Returns a shallow copy of this [VowMembership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VowMembership copyWith({
    int? id,
    int? roomId,
    String? userId,
    String? displayName,
    String? role,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowMembership',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'role': role,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowMembership',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'role': role,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowMembershipImpl extends VowMembership {
  _VowMembershipImpl({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    String? role,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         displayName: displayName,
         role: role,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [VowMembership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VowMembership copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? userId,
    String? displayName,
    String? role,
    DateTime? joinedAt,
  }) {
    return VowMembership(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
