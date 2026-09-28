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

/// Request to join an approval-gated vow room.
abstract class JoinRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JoinRequest._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.displayName,
    required this.status,
    required this.createdAt,
  });

  factory JoinRequest({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String status,
    required DateTime createdAt,
  }) = _JoinRequestImpl;

  factory JoinRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return JoinRequest(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  String userId;

  String displayName;

  /// pending | approved | rejected
  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [JoinRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JoinRequest copyWith({
    int? id,
    int? roomId,
    String? userId,
    String? displayName,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JoinRequest',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JoinRequest',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JoinRequestImpl extends JoinRequest {
  _JoinRequestImpl({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         displayName: displayName,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [JoinRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JoinRequest copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? userId,
    String? displayName,
    String? status,
    DateTime? createdAt,
  }) {
    return JoinRequest(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
