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

/// One member's status on the live board for today.
abstract class MemberDayStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemberDayStatus._({
    required this.userId,
    required this.displayName,
    required this.role,
    this.kept,
    this.note,
  });

  factory MemberDayStatus({
    required String userId,
    required String displayName,
    required String role,
    bool? kept,
    String? note,
  }) = _MemberDayStatusImpl;

  factory MemberDayStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberDayStatus(
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      role: jsonSerialization['role'] as String,
      kept: jsonSerialization['kept'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['kept']),
      note: jsonSerialization['note'] as String?,
    );
  }

  String userId;

  String displayName;

  /// owner | admin | member
  String role;

  /// null = not checked in yet.
  bool? kept;

  String? note;

  /// Returns a shallow copy of this [MemberDayStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemberDayStatus copyWith({
    String? userId,
    String? displayName,
    String? role,
    bool? kept,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberDayStatus',
      'userId': userId,
      'displayName': displayName,
      'role': role,
      if (kept != null) 'kept': kept,
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberDayStatus',
      'userId': userId,
      'displayName': displayName,
      'role': role,
      if (kept != null) 'kept': kept,
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberDayStatusImpl extends MemberDayStatus {
  _MemberDayStatusImpl({
    required String userId,
    required String displayName,
    required String role,
    bool? kept,
    String? note,
  }) : super._(
         userId: userId,
         displayName: displayName,
         role: role,
         kept: kept,
         note: note,
       );

  /// Returns a shallow copy of this [MemberDayStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemberDayStatus copyWith({
    String? userId,
    String? displayName,
    String? role,
    Object? kept = _Undefined,
    Object? note = _Undefined,
  }) {
    return MemberDayStatus(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      kept: kept is bool? ? kept : this.kept,
      note: note is String? ? note : this.note,
    );
  }
}
