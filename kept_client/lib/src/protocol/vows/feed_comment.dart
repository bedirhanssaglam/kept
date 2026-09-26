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

/// A comment on a home-feed target (activity message or article).
abstract class FeedComment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedComment._({
    this.id,
    required this.userId,
    required this.displayName,
    required this.targetType,
    required this.targetId,
    required this.body,
    required this.createdAt,
  });

  factory FeedComment({
    int? id,
    required String userId,
    required String displayName,
    required String targetType,
    required int targetId,
    required String body,
    required DateTime createdAt,
  }) = _FeedCommentImpl;

  factory FeedComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedComment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      body: jsonSerialization['body'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  String displayName;

  /// message | article
  String targetType;

  int targetId;

  String body;

  DateTime createdAt;

  /// Returns a shallow copy of this [FeedComment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedComment copyWith({
    int? id,
    String? userId,
    String? displayName,
    String? targetType,
    int? targetId,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedComment',
      if (id != null) 'id': id,
      'userId': userId,
      'displayName': displayName,
      'targetType': targetType,
      'targetId': targetId,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedComment',
      if (id != null) 'id': id,
      'userId': userId,
      'displayName': displayName,
      'targetType': targetType,
      'targetId': targetId,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedCommentImpl extends FeedComment {
  _FeedCommentImpl({
    int? id,
    required String userId,
    required String displayName,
    required String targetType,
    required int targetId,
    required String body,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         displayName: displayName,
         targetType: targetType,
         targetId: targetId,
         body: body,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FeedComment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedComment copyWith({
    Object? id = _Undefined,
    String? userId,
    String? displayName,
    String? targetType,
    int? targetId,
    String? body,
    DateTime? createdAt,
  }) {
    return FeedComment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
