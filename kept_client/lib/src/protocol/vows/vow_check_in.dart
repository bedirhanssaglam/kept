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

/// One user's daily keep/break for a room.
abstract class VowCheckIn
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VowCheckIn._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.dayKey,
    required this.kept,
    this.note,
    required this.createdAt,
  });

  factory VowCheckIn({
    int? id,
    required int roomId,
    required String userId,
    required String dayKey,
    required bool kept,
    String? note,
    required DateTime createdAt,
  }) = _VowCheckInImpl;

  factory VowCheckIn.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowCheckIn(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as String,
      dayKey: jsonSerialization['dayKey'] as String,
      kept: _isc.BoolJsonExtension.fromJson(jsonSerialization['kept']),
      note: jsonSerialization['note'] as String?,
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

  /// Calendar day in UTC, format YYYY-MM-DD.
  String dayKey;

  /// True = kept the vow, false = broke it.
  bool kept;

  String? note;

  DateTime createdAt;

  /// Returns a shallow copy of this [VowCheckIn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VowCheckIn copyWith({
    int? id,
    int? roomId,
    String? userId,
    String? dayKey,
    bool? kept,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowCheckIn',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'dayKey': dayKey,
      'kept': kept,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowCheckIn',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'dayKey': dayKey,
      'kept': kept,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowCheckInImpl extends VowCheckIn {
  _VowCheckInImpl({
    int? id,
    required int roomId,
    required String userId,
    required String dayKey,
    required bool kept,
    String? note,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         dayKey: dayKey,
         kept: kept,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VowCheckIn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VowCheckIn copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? userId,
    String? dayKey,
    bool? kept,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return VowCheckIn(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      dayKey: dayKey ?? this.dayKey,
      kept: kept ?? this.kept,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
