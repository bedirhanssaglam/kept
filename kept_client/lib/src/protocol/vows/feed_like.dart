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

/// A like on a home-feed target (activity message or article).
abstract class FeedLike
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedLike._({
    this.id,
    required this.userId,
    required this.targetType,
    required this.targetId,
    required this.createdAt,
  });

  factory FeedLike({
    int? id,
    required String userId,
    required String targetType,
    required int targetId,
    required DateTime createdAt,
  }) = _FeedLikeImpl;

  factory FeedLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedLike(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
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

  /// message | article
  String targetType;

  int targetId;

  DateTime createdAt;

  /// Returns a shallow copy of this [FeedLike]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedLike copyWith({
    int? id,
    String? userId,
    String? targetType,
    int? targetId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedLike',
      if (id != null) 'id': id,
      'userId': userId,
      'targetType': targetType,
      'targetId': targetId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedLike',
      if (id != null) 'id': id,
      'userId': userId,
      'targetType': targetType,
      'targetId': targetId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedLikeImpl extends FeedLike {
  _FeedLikeImpl({
    int? id,
    required String userId,
    required String targetType,
    required int targetId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         targetType: targetType,
         targetId: targetId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FeedLike]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedLike copyWith({
    Object? id = _Undefined,
    String? userId,
    String? targetType,
    int? targetId,
    DateTime? createdAt,
  }) {
    return FeedLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
