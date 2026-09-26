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
import 'package:serverpod/serverpod.dart' as _is;

/// One row in the public activity feed (message + room context).
abstract class FeedItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FeedItem._({
    required this.messageId,
    required this.roomId,
    required this.roomTitle,
    required this.roomCategory,
    required this.displayName,
    required this.kind,
    required this.body,
    required this.createdAt,
  });

  factory FeedItem({
    required int messageId,
    required int roomId,
    required String roomTitle,
    required String roomCategory,
    required String displayName,
    required String kind,
    required String body,
    required DateTime createdAt,
  }) = _FeedItemImpl;

  factory FeedItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedItem(
      messageId: jsonSerialization['messageId'] as int,
      roomId: jsonSerialization['roomId'] as int,
      roomTitle: jsonSerialization['roomTitle'] as String,
      roomCategory: jsonSerialization['roomCategory'] as String,
      displayName: jsonSerialization['displayName'] as String,
      kind: jsonSerialization['kind'] as String,
      body: jsonSerialization['body'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int messageId;

  int roomId;

  String roomTitle;

  String roomCategory;

  String displayName;

  /// chat | kept | broke | joined
  String kind;

  String body;

  DateTime createdAt;

  /// Returns a shallow copy of this [FeedItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedItem copyWith({
    int? messageId,
    int? roomId,
    String? roomTitle,
    String? roomCategory,
    String? displayName,
    String? kind,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedItem',
      'messageId': messageId,
      'roomId': roomId,
      'roomTitle': roomTitle,
      'roomCategory': roomCategory,
      'displayName': displayName,
      'kind': kind,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedItem',
      'messageId': messageId,
      'roomId': roomId,
      'roomTitle': roomTitle,
      'roomCategory': roomCategory,
      'displayName': displayName,
      'kind': kind,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FeedItemImpl extends FeedItem {
  _FeedItemImpl({
    required int messageId,
    required int roomId,
    required String roomTitle,
    required String roomCategory,
    required String displayName,
    required String kind,
    required String body,
    required DateTime createdAt,
  }) : super._(
         messageId: messageId,
         roomId: roomId,
         roomTitle: roomTitle,
         roomCategory: roomCategory,
         displayName: displayName,
         kind: kind,
         body: body,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FeedItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedItem copyWith({
    int? messageId,
    int? roomId,
    String? roomTitle,
    String? roomCategory,
    String? displayName,
    String? kind,
    String? body,
    DateTime? createdAt,
  }) {
    return FeedItem(
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      roomTitle: roomTitle ?? this.roomTitle,
      roomCategory: roomCategory ?? this.roomCategory,
      displayName: displayName ?? this.displayName,
      kind: kind ?? this.kind,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
