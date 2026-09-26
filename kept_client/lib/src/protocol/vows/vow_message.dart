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

/// A chat or activity line inside a vow room.
abstract class VowMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VowMessage._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.displayName,
    required this.kind,
    required this.body,
    bool? sharedToFeed,
    required this.createdAt,
  }) : sharedToFeed = sharedToFeed ?? false;

  factory VowMessage({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String kind,
    required String body,
    bool? sharedToFeed,
    required DateTime createdAt,
  }) = _VowMessageImpl;

  factory VowMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowMessage(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      kind: jsonSerialization['kind'] as String,
      body: jsonSerialization['body'] as String,
      sharedToFeed: jsonSerialization['sharedToFeed'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['sharedToFeed']),
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

  /// chat | kept | broke | joined
  String kind;

  String body;

  /// Only true posts appear on the public home feed.
  bool sharedToFeed;

  DateTime createdAt;

  /// Returns a shallow copy of this [VowMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VowMessage copyWith({
    int? id,
    int? roomId,
    String? userId,
    String? displayName,
    String? kind,
    String? body,
    bool? sharedToFeed,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'kind': kind,
      'body': body,
      'sharedToFeed': sharedToFeed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'kind': kind,
      'body': body,
      'sharedToFeed': sharedToFeed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowMessageImpl extends VowMessage {
  _VowMessageImpl({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String kind,
    required String body,
    bool? sharedToFeed,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         displayName: displayName,
         kind: kind,
         body: body,
         sharedToFeed: sharedToFeed,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VowMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VowMessage copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? userId,
    String? displayName,
    String? kind,
    String? body,
    bool? sharedToFeed,
    DateTime? createdAt,
  }) {
    return VowMessage(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      kind: kind ?? this.kind,
      body: body ?? this.body,
      sharedToFeed: sharedToFeed ?? this.sharedToFeed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
