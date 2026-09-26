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

/// A vow the signed-in viewer has not checked in for on their local day.
abstract class OpenVow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OpenVow._({
    required this.roomId,
    required this.title,
    required this.rule,
    required this.category,
    required this.memberTotal,
    required this.keptCount,
    required this.brokenCount,
    required this.pendingCount,
  });

  factory OpenVow({
    required int roomId,
    required String title,
    required String rule,
    required String category,
    required int memberTotal,
    required int keptCount,
    required int brokenCount,
    required int pendingCount,
  }) = _OpenVowImpl;

  factory OpenVow.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpenVow(
      roomId: jsonSerialization['roomId'] as int,
      title: jsonSerialization['title'] as String,
      rule: jsonSerialization['rule'] as String,
      category: jsonSerialization['category'] as String,
      memberTotal: jsonSerialization['memberTotal'] as int,
      keptCount: jsonSerialization['keptCount'] as int,
      brokenCount: jsonSerialization['brokenCount'] as int,
      pendingCount: jsonSerialization['pendingCount'] as int,
    );
  }

  int roomId;

  String title;

  String rule;

  String category;

  int memberTotal;

  int keptCount;

  int brokenCount;

  int pendingCount;

  /// Returns a shallow copy of this [OpenVow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OpenVow copyWith({
    int? roomId,
    String? title,
    String? rule,
    String? category,
    int? memberTotal,
    int? keptCount,
    int? brokenCount,
    int? pendingCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpenVow',
      'roomId': roomId,
      'title': title,
      'rule': rule,
      'category': category,
      'memberTotal': memberTotal,
      'keptCount': keptCount,
      'brokenCount': brokenCount,
      'pendingCount': pendingCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpenVow',
      'roomId': roomId,
      'title': title,
      'rule': rule,
      'category': category,
      'memberTotal': memberTotal,
      'keptCount': keptCount,
      'brokenCount': brokenCount,
      'pendingCount': pendingCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OpenVowImpl extends OpenVow {
  _OpenVowImpl({
    required int roomId,
    required String title,
    required String rule,
    required String category,
    required int memberTotal,
    required int keptCount,
    required int brokenCount,
    required int pendingCount,
  }) : super._(
         roomId: roomId,
         title: title,
         rule: rule,
         category: category,
         memberTotal: memberTotal,
         keptCount: keptCount,
         brokenCount: brokenCount,
         pendingCount: pendingCount,
       );

  /// Returns a shallow copy of this [OpenVow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OpenVow copyWith({
    int? roomId,
    String? title,
    String? rule,
    String? category,
    int? memberTotal,
    int? keptCount,
    int? brokenCount,
    int? pendingCount,
  }) {
    return OpenVow(
      roomId: roomId ?? this.roomId,
      title: title ?? this.title,
      rule: rule ?? this.rule,
      category: category ?? this.category,
      memberTotal: memberTotal ?? this.memberTotal,
      keptCount: keptCount ?? this.keptCount,
      brokenCount: brokenCount ?? this.brokenCount,
      pendingCount: pendingCount ?? this.pendingCount,
    );
  }
}
