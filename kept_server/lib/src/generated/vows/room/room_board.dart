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
import '../../vows/room/member_day_status.dart' as _i82qh63q;
import '../../vows/room/vow_room.dart' as _ilg2vhxg;

/// Full board payload for a room on a given day.
abstract class RoomBoard
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RoomBoard._({
    required this.room,
    required this.dayKey,
    required this.members,
    required this.keptCount,
    required this.brokenCount,
    required this.pendingCount,
    required this.isMember,
    required this.isAdmin,
    this.myRequestStatus,
    required this.memberTotal,
    required this.pendingRequestCount,
    required this.yesterdayDayKey,
    required this.yesterdayKeptCount,
    required this.yesterdayBrokenCount,
    required this.silentNames,
  });

  factory RoomBoard({
    required _ilg2vhxg.VowRoom room,
    required String dayKey,
    required List<_i82qh63q.MemberDayStatus> members,
    required int keptCount,
    required int brokenCount,
    required int pendingCount,
    required bool isMember,
    required bool isAdmin,
    String? myRequestStatus,
    required int memberTotal,
    required int pendingRequestCount,
    required String yesterdayDayKey,
    required int yesterdayKeptCount,
    required int yesterdayBrokenCount,
    required List<String> silentNames,
  }) = _RoomBoardImpl;

  factory RoomBoard.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomBoard(
      room: _iwxbvlzo.Protocol().deserialize<_ilg2vhxg.VowRoom>(
        jsonSerialization['room'],
      ),
      dayKey: jsonSerialization['dayKey'] as String,
      members: _iwxbvlzo.Protocol()
          .deserialize<List<_i82qh63q.MemberDayStatus>>(
            jsonSerialization['members'],
          ),
      keptCount: jsonSerialization['keptCount'] as int,
      brokenCount: jsonSerialization['brokenCount'] as int,
      pendingCount: jsonSerialization['pendingCount'] as int,
      isMember: _is.BoolJsonExtension.fromJson(jsonSerialization['isMember']),
      isAdmin: _is.BoolJsonExtension.fromJson(jsonSerialization['isAdmin']),
      myRequestStatus: jsonSerialization['myRequestStatus'] as String?,
      memberTotal: jsonSerialization['memberTotal'] as int,
      pendingRequestCount: jsonSerialization['pendingRequestCount'] as int,
      yesterdayDayKey: jsonSerialization['yesterdayDayKey'] as String,
      yesterdayKeptCount: jsonSerialization['yesterdayKeptCount'] as int,
      yesterdayBrokenCount: jsonSerialization['yesterdayBrokenCount'] as int,
      silentNames: _iwxbvlzo.Protocol().deserialize<List<String>>(
        jsonSerialization['silentNames'],
      ),
    );
  }

  _ilg2vhxg.VowRoom room;

  String dayKey;

  List<_i82qh63q.MemberDayStatus> members;

  int keptCount;

  int brokenCount;

  int pendingCount;

  /// Whether the current viewer is a member.
  bool isMember;

  /// Owner or admin of the room.
  bool isAdmin;

  /// pending if viewer has an open join request.
  String? myRequestStatus;

  /// Total members (board.members may be a page).
  int memberTotal;

  /// Pending join requests (admins only; 0 for others).
  int pendingRequestCount;

  /// The viewer's previous local calendar day.
  String yesterdayDayKey;

  int yesterdayKeptCount;

  int yesterdayBrokenCount;

  /// Names of members who have not checked in on [dayKey]. Capped.
  List<String> silentNames;

  /// Returns a shallow copy of this [RoomBoard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RoomBoard copyWith({
    _ilg2vhxg.VowRoom? room,
    String? dayKey,
    List<_i82qh63q.MemberDayStatus>? members,
    int? keptCount,
    int? brokenCount,
    int? pendingCount,
    bool? isMember,
    bool? isAdmin,
    String? myRequestStatus,
    int? memberTotal,
    int? pendingRequestCount,
    String? yesterdayDayKey,
    int? yesterdayKeptCount,
    int? yesterdayBrokenCount,
    List<String>? silentNames,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomBoard',
      'room': room.toJson(),
      'dayKey': dayKey,
      'members': members.toJson(valueToJson: (v) => v.toJson()),
      'keptCount': keptCount,
      'brokenCount': brokenCount,
      'pendingCount': pendingCount,
      'isMember': isMember,
      'isAdmin': isAdmin,
      if (myRequestStatus != null) 'myRequestStatus': myRequestStatus,
      'memberTotal': memberTotal,
      'pendingRequestCount': pendingRequestCount,
      'yesterdayDayKey': yesterdayDayKey,
      'yesterdayKeptCount': yesterdayKeptCount,
      'yesterdayBrokenCount': yesterdayBrokenCount,
      'silentNames': silentNames.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomBoard',
      'room': room.toJsonForProtocol(),
      'dayKey': dayKey,
      'members': members.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'keptCount': keptCount,
      'brokenCount': brokenCount,
      'pendingCount': pendingCount,
      'isMember': isMember,
      'isAdmin': isAdmin,
      if (myRequestStatus != null) 'myRequestStatus': myRequestStatus,
      'memberTotal': memberTotal,
      'pendingRequestCount': pendingRequestCount,
      'yesterdayDayKey': yesterdayDayKey,
      'yesterdayKeptCount': yesterdayKeptCount,
      'yesterdayBrokenCount': yesterdayBrokenCount,
      'silentNames': silentNames.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomBoardImpl extends RoomBoard {
  _RoomBoardImpl({
    required _ilg2vhxg.VowRoom room,
    required String dayKey,
    required List<_i82qh63q.MemberDayStatus> members,
    required int keptCount,
    required int brokenCount,
    required int pendingCount,
    required bool isMember,
    required bool isAdmin,
    String? myRequestStatus,
    required int memberTotal,
    required int pendingRequestCount,
    required String yesterdayDayKey,
    required int yesterdayKeptCount,
    required int yesterdayBrokenCount,
    required List<String> silentNames,
  }) : super._(
         room: room,
         dayKey: dayKey,
         members: members,
         keptCount: keptCount,
         brokenCount: brokenCount,
         pendingCount: pendingCount,
         isMember: isMember,
         isAdmin: isAdmin,
         myRequestStatus: myRequestStatus,
         memberTotal: memberTotal,
         pendingRequestCount: pendingRequestCount,
         yesterdayDayKey: yesterdayDayKey,
         yesterdayKeptCount: yesterdayKeptCount,
         yesterdayBrokenCount: yesterdayBrokenCount,
         silentNames: silentNames,
       );

  /// Returns a shallow copy of this [RoomBoard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RoomBoard copyWith({
    _ilg2vhxg.VowRoom? room,
    String? dayKey,
    List<_i82qh63q.MemberDayStatus>? members,
    int? keptCount,
    int? brokenCount,
    int? pendingCount,
    bool? isMember,
    bool? isAdmin,
    Object? myRequestStatus = _Undefined,
    int? memberTotal,
    int? pendingRequestCount,
    String? yesterdayDayKey,
    int? yesterdayKeptCount,
    int? yesterdayBrokenCount,
    List<String>? silentNames,
  }) {
    return RoomBoard(
      room: room ?? this.room.copyWith(),
      dayKey: dayKey ?? this.dayKey,
      members: members ?? this.members.map((e0) => e0.copyWith()).toList(),
      keptCount: keptCount ?? this.keptCount,
      brokenCount: brokenCount ?? this.brokenCount,
      pendingCount: pendingCount ?? this.pendingCount,
      isMember: isMember ?? this.isMember,
      isAdmin: isAdmin ?? this.isAdmin,
      myRequestStatus: myRequestStatus is String?
          ? myRequestStatus
          : this.myRequestStatus,
      memberTotal: memberTotal ?? this.memberTotal,
      pendingRequestCount: pendingRequestCount ?? this.pendingRequestCount,
      yesterdayDayKey: yesterdayDayKey ?? this.yesterdayDayKey,
      yesterdayKeptCount: yesterdayKeptCount ?? this.yesterdayKeptCount,
      yesterdayBrokenCount: yesterdayBrokenCount ?? this.yesterdayBrokenCount,
      silentNames: silentNames ?? this.silentNames.map((e0) => e0).toList(),
    );
  }
}
