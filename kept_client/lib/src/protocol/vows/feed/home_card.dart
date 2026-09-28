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
import 'package:kept_client/src/protocol/protocol.dart' as _i2yvbr9h;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../vows/feed/blog_post.dart' as _iampw9yc;
import '../../vows/feed/feed_item.dart' as _isej9s1z;

/// One card in the Instagram-style home timeline.
abstract class HomeCard
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  HomeCard._({
    required this.type,
    required this.createdAt,
    this.activity,
    this.article,
    required this.likeCount,
    required this.commentCount,
    required this.likedByMe,
    required this.targetType,
    required this.targetId,
  });

  factory HomeCard({
    required String type,
    required DateTime createdAt,
    _isej9s1z.FeedItem? activity,
    _iampw9yc.BlogPost? article,
    required int likeCount,
    required int commentCount,
    required bool likedByMe,
    required String targetType,
    required int targetId,
  }) = _HomeCardImpl;

  factory HomeCard.fromJson(Map<String, dynamic> jsonSerialization) {
    return HomeCard(
      type: jsonSerialization['type'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      activity: jsonSerialization['activity'] == null
          ? null
          : _i2yvbr9h.Protocol().deserialize<_isej9s1z.FeedItem>(
              jsonSerialization['activity'],
            ),
      article: jsonSerialization['article'] == null
          ? null
          : _i2yvbr9h.Protocol().deserialize<_iampw9yc.BlogPost>(
              jsonSerialization['article'],
            ),
      likeCount: jsonSerialization['likeCount'] as int,
      commentCount: jsonSerialization['commentCount'] as int,
      likedByMe: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['likedByMe'],
      ),
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
    );
  }

  /// activity | article
  String type;

  DateTime createdAt;

  _isej9s1z.FeedItem? activity;

  _iampw9yc.BlogPost? article;

  int likeCount;

  int commentCount;

  bool likedByMe;

  /// message | article — used by like/comment RPCs
  String targetType;

  int targetId;

  /// Returns a shallow copy of this [HomeCard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  HomeCard copyWith({
    String? type,
    DateTime? createdAt,
    _isej9s1z.FeedItem? activity,
    _iampw9yc.BlogPost? article,
    int? likeCount,
    int? commentCount,
    bool? likedByMe,
    String? targetType,
    int? targetId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HomeCard',
      'type': type,
      'createdAt': createdAt.toJson(),
      if (activity != null) 'activity': activity?.toJson(),
      if (article != null) 'article': article?.toJson(),
      'likeCount': likeCount,
      'commentCount': commentCount,
      'likedByMe': likedByMe,
      'targetType': targetType,
      'targetId': targetId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HomeCard',
      'type': type,
      'createdAt': createdAt.toJson(),
      if (activity != null) 'activity': activity?.toJsonForProtocol(),
      if (article != null) 'article': article?.toJsonForProtocol(),
      'likeCount': likeCount,
      'commentCount': commentCount,
      'likedByMe': likedByMe,
      'targetType': targetType,
      'targetId': targetId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HomeCardImpl extends HomeCard {
  _HomeCardImpl({
    required String type,
    required DateTime createdAt,
    _isej9s1z.FeedItem? activity,
    _iampw9yc.BlogPost? article,
    required int likeCount,
    required int commentCount,
    required bool likedByMe,
    required String targetType,
    required int targetId,
  }) : super._(
         type: type,
         createdAt: createdAt,
         activity: activity,
         article: article,
         likeCount: likeCount,
         commentCount: commentCount,
         likedByMe: likedByMe,
         targetType: targetType,
         targetId: targetId,
       );

  /// Returns a shallow copy of this [HomeCard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  HomeCard copyWith({
    String? type,
    DateTime? createdAt,
    Object? activity = _Undefined,
    Object? article = _Undefined,
    int? likeCount,
    int? commentCount,
    bool? likedByMe,
    String? targetType,
    int? targetId,
  }) {
    return HomeCard(
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      activity: activity is _isej9s1z.FeedItem?
          ? activity
          : this.activity?.copyWith(),
      article: article is _iampw9yc.BlogPost?
          ? article
          : this.article?.copyWith(),
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      likedByMe: likedByMe ?? this.likedByMe,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
    );
  }
}
