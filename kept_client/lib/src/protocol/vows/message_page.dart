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
import '../vows/vow_message.dart' as _iov7d9dl;

/// Offset page of room chat messages.
abstract class MessagePage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MessagePage._({
    required this.items,
    required this.totalCount,
    required this.limit,
    required this.offset,
    required this.hasMore,
  });

  factory MessagePage({
    required List<_iov7d9dl.VowMessage> items,
    required int totalCount,
    required int limit,
    required int offset,
    required bool hasMore,
  }) = _MessagePageImpl;

  factory MessagePage.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessagePage(
      items: _i2yvbr9h.Protocol().deserialize<List<_iov7d9dl.VowMessage>>(
        jsonSerialization['items'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
      hasMore: _isc.BoolJsonExtension.fromJson(jsonSerialization['hasMore']),
    );
  }

  List<_iov7d9dl.VowMessage> items;

  int totalCount;

  int limit;

  int offset;

  bool hasMore;

  /// Returns a shallow copy of this [MessagePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MessagePage copyWith({
    List<_iov7d9dl.VowMessage>? items,
    int? totalCount,
    int? limit,
    int? offset,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessagePage',
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
      '__className__': 'MessagePage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalCount': totalCount,
      'limit': limit,
      'offset': offset,
      'hasMore': hasMore,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MessagePageImpl extends MessagePage {
  _MessagePageImpl({
    required List<_iov7d9dl.VowMessage> items,
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

  /// Returns a shallow copy of this [MessagePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MessagePage copyWith({
    List<_iov7d9dl.VowMessage>? items,
    int? totalCount,
    int? limit,
    int? offset,
    bool? hasMore,
  }) {
    return MessagePage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
