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
import 'package:kept_server/src/generated/protocol.dart' as _iwxbvlzo;
import 'package:serverpod/serverpod.dart' as _is;
import '../vows/vow_room.dart' as _i182gio9;

/// Offset page of public vow rooms.
abstract class VowRoomPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VowRoomPage._({
    required this.items,
    required this.totalCount,
    required this.limit,
    required this.offset,
    required this.hasMore,
  });

  factory VowRoomPage({
    required List<_i182gio9.VowRoom> items,
    required int totalCount,
    required int limit,
    required int offset,
    required bool hasMore,
  }) = _VowRoomPageImpl;

  factory VowRoomPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowRoomPage(
      items: _iwxbvlzo.Protocol().deserialize<List<_i182gio9.VowRoom>>(
        jsonSerialization['items'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
      hasMore: _is.BoolJsonExtension.fromJson(jsonSerialization['hasMore']),
    );
  }

  List<_i182gio9.VowRoom> items;

  int totalCount;

  int limit;

  int offset;

  bool hasMore;

  /// Returns a shallow copy of this [VowRoomPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VowRoomPage copyWith({
    List<_i182gio9.VowRoom>? items,
    int? totalCount,
    int? limit,
    int? offset,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowRoomPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
      'limit': limit,
      'offset': offset,
      'hasMore': hasMore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowRoomPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalCount': totalCount,
      'limit': limit,
      'offset': offset,
      'hasMore': hasMore,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _VowRoomPageImpl extends VowRoomPage {
  _VowRoomPageImpl({
    required List<_i182gio9.VowRoom> items,
    required int totalCount,
    required int limit,
    required int offset,
    required bool hasMore,
  }) : super._(
         items: items,
         totalCount: totalCount,
         limit: limit,
         offset: offset,
         hasMore: hasMore,
       );

  /// Returns a shallow copy of this [VowRoomPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VowRoomPage copyWith({
    List<_i182gio9.VowRoom>? items,
    int? totalCount,
    int? limit,
    int? offset,
    bool? hasMore,
  }) {
    return VowRoomPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
