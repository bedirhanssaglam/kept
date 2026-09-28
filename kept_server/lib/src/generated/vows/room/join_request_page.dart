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
import '../../vows/room/join_request.dart' as _i5lag4nq;

/// Offset page of join requests.
abstract class JoinRequestPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  JoinRequestPage._({
    required this.items,
    required this.totalCount,
    required this.limit,
    required this.offset,
    required this.hasMore,
  });

  factory JoinRequestPage({
    required List<_i5lag4nq.JoinRequest> items,
    required int totalCount,
    required int limit,
    required int offset,
    required bool hasMore,
  }) = _JoinRequestPageImpl;

  factory JoinRequestPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return JoinRequestPage(
      items: _iwxbvlzo.Protocol().deserialize<List<_i5lag4nq.JoinRequest>>(
        jsonSerialization['items'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
      hasMore: _is.BoolJsonExtension.fromJson(jsonSerialization['hasMore']),
    );
  }

  List<_i5lag4nq.JoinRequest> items;

  int totalCount;

  int limit;

  int offset;

  bool hasMore;

  /// Returns a shallow copy of this [JoinRequestPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JoinRequestPage copyWith({
    List<_i5lag4nq.JoinRequest>? items,
    int? totalCount,
    int? limit,
    int? offset,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JoinRequestPage',
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
      '__className__': 'JoinRequestPage',
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

class _JoinRequestPageImpl extends JoinRequestPage {
  _JoinRequestPageImpl({
    required List<_i5lag4nq.JoinRequest> items,
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

  /// Returns a shallow copy of this [JoinRequestPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JoinRequestPage copyWith({
    List<_i5lag4nq.JoinRequest>? items,
    int? totalCount,
    int? limit,
    int? offset,
    bool? hasMore,
  }) {
    return JoinRequestPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
