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
import '../../vows/room/vow_room.dart' as _ilg2vhxg;

/// Signed-in member snapshot for the Profile tab.
abstract class KeptProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  KeptProfile._({
    required this.userId,
    required this.displayName,
    required this.memberRoomCount,
    required this.keptToday,
    required this.brokeToday,
    required this.pendingToday,
    required this.rooms,
  });

  factory KeptProfile({
    required String userId,
    required String displayName,
    required int memberRoomCount,
    required int keptToday,
    required int brokeToday,
    required int pendingToday,
    required List<_ilg2vhxg.VowRoom> rooms,
  }) = _KeptProfileImpl;

  factory KeptProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return KeptProfile(
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      memberRoomCount: jsonSerialization['memberRoomCount'] as int,
      keptToday: jsonSerialization['keptToday'] as int,
      brokeToday: jsonSerialization['brokeToday'] as int,
      pendingToday: jsonSerialization['pendingToday'] as int,
      rooms: _i2yvbr9h.Protocol().deserialize<List<_ilg2vhxg.VowRoom>>(
        jsonSerialization['rooms'],
      ),
    );
  }

  String userId;

  String displayName;

  int memberRoomCount;

  int keptToday;

  int brokeToday;

  int pendingToday;

  List<_ilg2vhxg.VowRoom> rooms;

  /// Returns a shallow copy of this [KeptProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  KeptProfile copyWith({
    String? userId,
    String? displayName,
    int? memberRoomCount,
    int? keptToday,
    int? brokeToday,
    int? pendingToday,
    List<_ilg2vhxg.VowRoom>? rooms,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KeptProfile',
      'userId': userId,
      'displayName': displayName,
      'memberRoomCount': memberRoomCount,
      'keptToday': keptToday,
      'brokeToday': brokeToday,
      'pendingToday': pendingToday,
      'rooms': rooms.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'KeptProfile',
      'userId': userId,
      'displayName': displayName,
      'memberRoomCount': memberRoomCount,
      'keptToday': keptToday,
      'brokeToday': brokeToday,
      'pendingToday': pendingToday,
      'rooms': rooms.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _KeptProfileImpl extends KeptProfile {
  _KeptProfileImpl({
    required String userId,
    required String displayName,
    required int memberRoomCount,
    required int keptToday,
    required int brokeToday,
    required int pendingToday,
    required List<_ilg2vhxg.VowRoom> rooms,
  }) : super._(
         userId: userId,
         displayName: displayName,
         memberRoomCount: memberRoomCount,
         keptToday: keptToday,
         brokeToday: brokeToday,
         pendingToday: pendingToday,
         rooms: rooms,
       );

  /// Returns a shallow copy of this [KeptProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  KeptProfile copyWith({
    String? userId,
    String? displayName,
    int? memberRoomCount,
    int? keptToday,
    int? brokeToday,
    int? pendingToday,
    List<_ilg2vhxg.VowRoom>? rooms,
  }) {
    return KeptProfile(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      memberRoomCount: memberRoomCount ?? this.memberRoomCount,
      keptToday: keptToday ?? this.keptToday,
      brokeToday: brokeToday ?? this.brokeToday,
      pendingToday: pendingToday ?? this.pendingToday,
      rooms: rooms ?? this.rooms.map((e0) => e0.copyWith()).toList(),
    );
  }
}
