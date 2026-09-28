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

/// Invite code for invite-only vow rooms.
abstract class VowInvite
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VowInvite._({
    this.id,
    required this.roomId,
    required this.code,
    required this.createdBy,
    required this.createdAt,
    int? maxUses,
    int? useCount,
  }) : maxUses = maxUses ?? 0,
       useCount = useCount ?? 0;

  factory VowInvite({
    int? id,
    required int roomId,
    required String code,
    required String createdBy,
    required DateTime createdAt,
    int? maxUses,
    int? useCount,
  }) = _VowInviteImpl;

  factory VowInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowInvite(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      code: jsonSerialization['code'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      maxUses: jsonSerialization['maxUses'] as int?,
      useCount: jsonSerialization['useCount'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  String code;

  String createdBy;

  DateTime createdAt;

  /// 0 = unlimited
  int maxUses;

  int useCount;

  /// Returns a shallow copy of this [VowInvite]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VowInvite copyWith({
    int? id,
    int? roomId,
    String? code,
    String? createdBy,
    DateTime? createdAt,
    int? maxUses,
    int? useCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowInvite',
      if (id != null) 'id': id,
      'roomId': roomId,
      'code': code,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'maxUses': maxUses,
      'useCount': useCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowInvite',
      if (id != null) 'id': id,
      'roomId': roomId,
      'code': code,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'maxUses': maxUses,
      'useCount': useCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowInviteImpl extends VowInvite {
  _VowInviteImpl({
    int? id,
    required int roomId,
    required String code,
    required String createdBy,
    required DateTime createdAt,
    int? maxUses,
    int? useCount,
  }) : super._(
         id: id,
         roomId: roomId,
         code: code,
         createdBy: createdBy,
         createdAt: createdAt,
         maxUses: maxUses,
         useCount: useCount,
       );

  /// Returns a shallow copy of this [VowInvite]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VowInvite copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? code,
    String? createdBy,
    DateTime? createdAt,
    int? maxUses,
    int? useCount,
  }) {
    return VowInvite(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      code: code ?? this.code,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      maxUses: maxUses ?? this.maxUses,
      useCount: useCount ?? this.useCount,
    );
  }
}
