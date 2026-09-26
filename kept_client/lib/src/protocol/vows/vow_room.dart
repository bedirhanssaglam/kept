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

/// A public or private vow room people can join.
abstract class VowRoom
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VowRoom._({
    this.id,
    required this.title,
    required this.rule,
    required this.category,
    required this.isPublic,
    String? joinPolicy,
    bool? isOfficial,
    required this.creatorId,
    required this.memberCount,
    required this.createdAt,
  }) : joinPolicy = joinPolicy ?? 'open',
       isOfficial = isOfficial ?? false;

  factory VowRoom({
    int? id,
    required String title,
    required String rule,
    required String category,
    required bool isPublic,
    String? joinPolicy,
    bool? isOfficial,
    required String creatorId,
    required int memberCount,
    required DateTime createdAt,
  }) = _VowRoomImpl;

  factory VowRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowRoom(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      rule: jsonSerialization['rule'] as String,
      category: jsonSerialization['category'] as String,
      isPublic: _isc.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      joinPolicy: jsonSerialization['joinPolicy'] as String?,
      isOfficial: jsonSerialization['isOfficial'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isOfficial']),
      creatorId: jsonSerialization['creatorId'] as String,
      memberCount: jsonSerialization['memberCount'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Short vow title, e.g. "Drink 1L of water".
  String title;

  /// What "kept" means today.
  String rule;

  /// Category slug: health | quit | move | focus | custom
  String category;

  /// Whether the room appears on Discover / Home stories.
  bool isPublic;

  /// open | approval | invite | closed
  String joinPolicy;

  /// Curated default vows (system).
  bool isOfficial;

  /// Auth user id of the creator / owner.
  String creatorId;

  /// Cached member count for Discover cards.
  int memberCount;

  /// UTC creation time.
  DateTime createdAt;

  /// Returns a shallow copy of this [VowRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VowRoom copyWith({
    int? id,
    String? title,
    String? rule,
    String? category,
    bool? isPublic,
    String? joinPolicy,
    bool? isOfficial,
    String? creatorId,
    int? memberCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowRoom',
      if (id != null) 'id': id,
      'title': title,
      'rule': rule,
      'category': category,
      'isPublic': isPublic,
      'joinPolicy': joinPolicy,
      'isOfficial': isOfficial,
      'creatorId': creatorId,
      'memberCount': memberCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowRoom',
      if (id != null) 'id': id,
      'title': title,
      'rule': rule,
      'category': category,
      'isPublic': isPublic,
      'joinPolicy': joinPolicy,
      'isOfficial': isOfficial,
      'creatorId': creatorId,
      'memberCount': memberCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowRoomImpl extends VowRoom {
  _VowRoomImpl({
    int? id,
    required String title,
    required String rule,
    required String category,
    required bool isPublic,
    String? joinPolicy,
    bool? isOfficial,
    required String creatorId,
    required int memberCount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         rule: rule,
         category: category,
         isPublic: isPublic,
         joinPolicy: joinPolicy,
         isOfficial: isOfficial,
         creatorId: creatorId,
         memberCount: memberCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VowRoom]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VowRoom copyWith({
    Object? id = _Undefined,
    String? title,
    String? rule,
    String? category,
    bool? isPublic,
    String? joinPolicy,
    bool? isOfficial,
    String? creatorId,
    int? memberCount,
    DateTime? createdAt,
  }) {
    return VowRoom(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      rule: rule ?? this.rule,
      category: category ?? this.category,
      isPublic: isPublic ?? this.isPublic,
      joinPolicy: joinPolicy ?? this.joinPolicy,
      isOfficial: isOfficial ?? this.isOfficial,
      creatorId: creatorId ?? this.creatorId,
      memberCount: memberCount ?? this.memberCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
