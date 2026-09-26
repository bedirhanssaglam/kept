import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Vow rooms, daily keep/break, live boards, and room chat.
class VowEndpoint extends Endpoint {
  static String _boardChannel(int roomId) => 'vow-board-$roomId';
  static String _chatChannel(int roomId) => 'vow-chat-$roomId';

  static final _dayPattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  static const _silentNameCap = 24;

  String _formatDate(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  /// Viewer's local calendar day. A missing key falls back to UTC today.
  /// Keys more than a day away from UTC today are rejected so a client cannot
  /// rewrite an old day. ±1 covers every real timezone offset.
  String _resolveDayKey(String? raw) {
    final utc = DateTime.now().toUtc();
    final utcToday = DateTime.utc(utc.year, utc.month, utc.day);
    if (raw == null || raw.trim().isEmpty) return _formatDate(utcToday);

    final key = raw.trim();
    if (!_dayPattern.hasMatch(key)) {
      throw VowException(message: 'That day is not valid.');
    }
    final parts = key.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final local = DateTime.utc(year, month, day);
    if (local.year != year || local.month != month || local.day != day) {
      throw VowException(message: 'That day is not valid.');
    }
    final delta = local.difference(utcToday).inDays;
    if (delta < -1 || delta > 1) {
      throw VowException(message: 'That day is closed.');
    }
    return key;
  }

  String _previousDay(String dayKey) {
    final parts = dayKey.split('-');
    final d = DateTime.utc(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    ).subtract(const Duration(days: 1));
    return _formatDate(d);
  }

  String _label(String userId) {
    if (userId.length <= 10) return userId;
    return 'member-${userId.substring(0, 6)}';
  }

  /// Global username from Serverpod [UserProfile], falling back to a short id.
  Future<String> _globalName(Session session, String userId) async {
    try {
      final authUserId = UuidValue.withValidation(userId);
      final profile = await AuthServices.instance.userProfiles
          .findUserProfileByUserId(session, authUserId);
      final name = profile.userName?.trim();
      if (name != null && name.isNotEmpty) return name;
    } catch (_) {
      // Profile missing or invalid id — fall through.
    }
    return _label(userId);
  }

  Future<void> _seedIfEmpty(Session session) async {
    final existing = await VowRoom.db.count(session);
    if (existing > 0) {
      await _ensureOfficialWaterVow(session);
      return;
    }

    final now = DateTime.now().toUtc();
    final seeds = <VowRoom>[
      VowRoom(
        title: 'Drink 2.5 liters of water',
        rule: 'Log once you’ve finished at least 2.5L today.',
        category: 'health',
        isPublic: true,
        joinPolicy: 'open',
        isOfficial: true,
        creatorId: 'system',
        memberCount: 0,
        createdAt: now,
      ),
      VowRoom(
        title: 'No cigarettes today',
        rule: 'Make it through the day without smoking.',
        category: 'quit',
        isPublic: true,
        joinPolicy: 'open',
        isOfficial: true,
        creatorId: 'system',
        memberCount: 0,
        createdAt: now,
      ),
      VowRoom(
        title: 'Walk 20 minutes',
        rule: 'A real walk counts — treadmill or outdoors.',
        category: 'move',
        isPublic: true,
        joinPolicy: 'open',
        isOfficial: true,
        creatorId: 'system',
        memberCount: 0,
        createdAt: now,
      ),
      VowRoom(
        title: 'Deep work for 45 minutes',
        rule: 'One uninterrupted focus block. Phone away.',
        category: 'focus',
        isPublic: true,
        joinPolicy: 'open',
        isOfficial: true,
        creatorId: 'system',
        memberCount: 0,
        createdAt: now,
      ),
    ];
    await VowRoom.db.insert(session, seeds);
  }

  Future<void> _ensureOfficialWaterVow(Session session) async {
    final found = await VowRoom.db.findFirstRow(
      session,
      where: (t) => t.title.equals('Drink 2.5 liters of water'),
    );
    if (found != null) {
      if (!found.isOfficial || found.joinPolicy != 'open') {
        await VowRoom.db.updateRow(
          session,
          found.copyWith(isOfficial: true, joinPolicy: 'open', isPublic: true),
        );
      }
      return;
    }
    await VowRoom.db.insertRow(
      session,
      VowRoom(
        title: 'Drink 2.5 liters of water',
        rule: 'Log once you’ve finished at least 2.5L today.',
        category: 'health',
        isPublic: true,
        joinPolicy: 'open',
        isOfficial: true,
        creatorId: 'system',
        memberCount: 0,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  int _clampLimit(int limit, {int max = 50}) => limit.clamp(1, max);

  Future<VowMessage> _postMessage(
    Session session, {
    required int roomId,
    required String userId,
    required String displayName,
    required String kind,
    required String body,
    bool sharedToFeed = false,
  }) async {
    final message = await VowMessage.db.insertRow(
      session,
      VowMessage(
        roomId: roomId,
        userId: userId,
        displayName: displayName,
        kind: kind,
        body: body,
        sharedToFeed: sharedToFeed,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await session.messages.postMessage(_chatChannel(roomId), message);
    return message;
  }

  Future<VowMembership?> _membershipOf(
    Session session, {
    required int roomId,
    required String userId,
  }) {
    return VowMembership.db.findFirstRow(
      session,
      where: (t) => t.roomId.equals(roomId) & t.userId.equals(userId),
    );
  }

  bool _isAdminRole(String? role) => role == 'owner' || role == 'admin';

  Future<({int kept, int broken, int pending, List<String> silent})> _tallyDay(
    Session session, {
    required int roomId,
    required String dayKey,
    required List<VowMembership> memberships,
  }) async {
    final checkIns = await VowCheckIn.db.find(
      session,
      where: (t) => t.roomId.equals(roomId) & t.dayKey.equals(dayKey),
    );
    final byUser = {for (final c in checkIns) c.userId: c};
    var kept = 0;
    var broken = 0;
    var pending = 0;
    final silent = <String>[];
    for (final m in memberships) {
      final c = byUser[m.userId];
      if (c == null) {
        pending++;
        if (silent.length < _silentNameCap) silent.add(m.displayName);
      } else if (c.kept) {
        kept++;
      } else {
        broken++;
      }
    }
    return (kept: kept, broken: broken, pending: pending, silent: silent);
  }

  Future<RoomBoard> _buildBoard(
    Session session,
    VowRoom room, {
    required String viewerId,
    String? dayKey,
    int memberLimit = 40,
  }) async {
    final today = _resolveDayKey(dayKey);
    final yesterdayKey = _previousDay(today);
    final memberTotal = await VowMembership.db.count(
      session,
      where: (t) => t.roomId.equals(room.id!),
    );
    final memberships = await VowMembership.db.find(
      session,
      where: (t) => t.roomId.equals(room.id!),
      orderBy: (t) => t.joinedAt,
      limit: memberLimit,
    );
    final todayCheckIns = await VowCheckIn.db.find(
      session,
      where: (t) => t.roomId.equals(room.id!) & t.dayKey.equals(today),
    );
    final byUser = {for (final c in todayCheckIns) c.userId: c};

    final members = <MemberDayStatus>[
      for (final m in memberships)
        MemberDayStatus(
          userId: m.userId,
          displayName: m.displayName,
          role: m.role,
          kept: byUser[m.userId]?.kept,
          note: byUser[m.userId]?.note,
        ),
    ];

    final allMemberships = memberTotal <= memberships.length
        ? memberships
        : await VowMembership.db.find(
            session,
            where: (t) => t.roomId.equals(room.id!),
            orderBy: (t) => t.joinedAt,
          );
    final todayStats = await _tallyDay(
      session,
      roomId: room.id!,
      dayKey: today,
      memberships: allMemberships,
    );
    final yesterdayStats = await _tallyDay(
      session,
      roomId: room.id!,
      dayKey: yesterdayKey,
      memberships: allMemberships,
    );

    final mine = await _membershipOf(
      session,
      roomId: room.id!,
      userId: viewerId,
    );
    String? requestStatus;
    if (mine == null && viewerId.isNotEmpty) {
      final req = await JoinRequest.db.findFirstRow(
        session,
        where: (t) =>
            t.roomId.equals(room.id!) &
            t.userId.equals(viewerId) &
            t.status.equals('pending'),
      );
      requestStatus = req?.status;
    }

    final isAdmin = _isAdminRole(mine?.role) || room.creatorId == viewerId;
    var pendingRequestCount = 0;
    if (isAdmin) {
      pendingRequestCount = await JoinRequest.db.count(
        session,
        where: (t) => t.roomId.equals(room.id!) & t.status.equals('pending'),
      );
    }

    return RoomBoard(
      room: room,
      dayKey: today,
      members: members,
      keptCount: todayStats.kept,
      brokenCount: todayStats.broken,
      pendingCount: todayStats.pending,
      isMember: mine != null,
      isAdmin: isAdmin,
      myRequestStatus: requestStatus,
      memberTotal: memberTotal,
      pendingRequestCount: pendingRequestCount,
      yesterdayDayKey: yesterdayKey,
      yesterdayKeptCount: yesterdayStats.kept,
      yesterdayBrokenCount: yesterdayStats.broken,
      silentNames: todayStats.silent,
    );
  }

  Future<void> _broadcastBoard(
    Session session,
    int roomId,
    RoomBoard board,
  ) async {
    await session.messages.postMessage(_boardChannel(roomId), board);
  }

  Future<VowRoomPage> listPublicRooms(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    await _seedIfEmpty(session);
    final capped = _clampLimit(limit);
    final start = offset < 0 ? 0 : offset;
    final total = await VowRoom.db.count(
      session,
      where: (t) => t.isPublic.equals(true),
    );
    final rooms = await VowRoom.db.find(
      session,
      where: (t) => t.isPublic.equals(true),
      orderByList: (t) => [t.isOfficial.desc(), t.memberCount.desc()],
      limit: capped,
      offset: start,
    );
    return VowRoomPage(
      items: rooms,
      totalCount: total,
      limit: capped,
      offset: start,
      hasMore: start + rooms.length < total,
    );
  }

  Future<VowRoom> createRoom(
    Session session, {
    required String title,
    required String rule,
    required String category,
    String? displayName,
    bool isPublic = true,
    String joinPolicy = 'open',
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to create a vow.');
    }
    final trimmedTitle = title.trim();
    final trimmedRule = rule.trim();
    if (trimmedTitle.isEmpty || trimmedRule.isEmpty) {
      throw VowException(message: 'Title and rule are required.');
    }
    const allowed = {'open', 'approval', 'invite', 'closed'};
    final policy = allowed.contains(joinPolicy) ? joinPolicy : 'open';

    final now = DateTime.now().toUtc();
    final name = (displayName?.trim().isNotEmpty == true)
        ? displayName!.trim()
        : await _globalName(session, auth.userIdentifier);

    final room = await VowRoom.db.insertRow(
      session,
      VowRoom(
        title: trimmedTitle,
        rule: trimmedRule,
        category: category,
        isPublic: isPublic,
        joinPolicy: policy,
        isOfficial: false,
        creatorId: auth.userIdentifier,
        memberCount: 1,
        createdAt: now,
      ),
    );

    await VowMembership.db.insertRow(
      session,
      VowMembership(
        roomId: room.id!,
        userId: auth.userIdentifier,
        displayName: name,
        role: 'owner',
        joinedAt: now,
      ),
    );

    await _postMessage(
      session,
      roomId: room.id!,
      userId: auth.userIdentifier,
      displayName: name,
      kind: 'joined',
      body: '$name created this vow and stepped in.',
    );

    return room;
  }

  Future<RoomBoard> _addMember(
    Session session, {
    required VowRoom room,
    required String userId,
    required String displayName,
    String role = 'member',
    String? dayKey,
  }) async {
    await VowMembership.db.insertRow(
      session,
      VowMembership(
        roomId: room.id!,
        userId: userId,
        displayName: displayName,
        role: role,
        joinedAt: DateTime.now().toUtc(),
      ),
    );
    await VowRoom.db.updateRow(
      session,
      room.copyWith(memberCount: room.memberCount + 1),
    );
    await _postMessage(
      session,
      roomId: room.id!,
      userId: userId,
      displayName: displayName,
      kind: 'joined',
      body: '$displayName joined the vow.',
    );
    final fresh = (await VowRoom.db.findById(session, room.id!))!;
    final board = await _buildBoard(
      session,
      fresh,
      viewerId: userId,
      dayKey: dayKey,
    );
    await _broadcastBoard(session, room.id!, board);
    return board;
  }

  /// Join an open room immediately. Other policies use requestJoin / joinWithInvite.
  Future<RoomBoard> joinRoom(
    Session session,
    int roomId, {
    String? displayName,
    String? dayKey,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to join a vow.');
    }

    final room = await VowRoom.db.findById(session, roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }

    final name = (displayName?.trim().isNotEmpty == true)
        ? displayName!.trim()
        : await _globalName(session, auth.userIdentifier);

    final existing = await _membershipOf(
      session,
      roomId: roomId,
      userId: auth.userIdentifier,
    );
    if (existing != null) {
      if (displayName?.trim().isNotEmpty == true &&
          existing.displayName != name) {
        await VowMembership.db.updateRow(
          session,
          existing.copyWith(displayName: name),
        );
      }
      return _buildBoard(
        session,
        room,
        viewerId: auth.userIdentifier,
        dayKey: dayKey,
      );
    }

    if (room.joinPolicy != 'open') {
      throw VowException(
        message: switch (room.joinPolicy) {
          'approval' =>
            'This vow needs admin approval. Request to join instead.',
          'invite' => 'This vow is invite-only. Enter an invite code.',
          'closed' => 'This vow is closed to new members.',
          _ => 'You cannot join this vow directly.',
        },
      );
    }

    return _addMember(
      session,
      room: room,
      userId: auth.userIdentifier,
      displayName: name,
      dayKey: dayKey,
    );
  }

  Future<JoinRequest> requestJoin(
    Session session,
    int roomId, {
    String? displayName,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to request joining.');
    }
    final room = await VowRoom.db.findById(session, roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }
    if (room.joinPolicy != 'approval') {
      throw VowException(message: 'This vow does not use join requests.');
    }
    final existing = await _membershipOf(
      session,
      roomId: roomId,
      userId: auth.userIdentifier,
    );
    if (existing != null) {
      throw VowException(message: 'You are already a member.');
    }

    final pending = await JoinRequest.db.findFirstRow(
      session,
      where: (t) =>
          t.roomId.equals(roomId) &
          t.userId.equals(auth.userIdentifier) &
          t.status.equals('pending'),
    );
    if (pending != null) return pending;

    final name = (displayName?.trim().isNotEmpty == true)
        ? displayName!.trim()
        : await _globalName(session, auth.userIdentifier);

    return JoinRequest.db.insertRow(
      session,
      JoinRequest(
        roomId: roomId,
        userId: auth.userIdentifier,
        displayName: name,
        status: 'pending',
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<RoomBoard> joinWithInvite(
    Session session, {
    required String code,
    String? displayName,
    String? dayKey,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to use an invite.');
    }
    final normalized = code.trim().toUpperCase();
    if (normalized.isEmpty) {
      throw VowException(message: 'Invite code is required.');
    }

    final invite = await VowInvite.db.findFirstRow(
      session,
      where: (t) => t.code.equals(normalized),
    );
    if (invite == null) {
      throw VowException(message: 'Invalid invite code.');
    }
    if (invite.maxUses > 0 && invite.useCount >= invite.maxUses) {
      throw VowException(message: 'This invite code is exhausted.');
    }

    final room = await VowRoom.db.findById(session, invite.roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }
    if (room.joinPolicy == 'closed') {
      throw VowException(message: 'This vow is closed.');
    }

    final name = (displayName?.trim().isNotEmpty == true)
        ? displayName!.trim()
        : await _globalName(session, auth.userIdentifier);

    final existing = await _membershipOf(
      session,
      roomId: room.id!,
      userId: auth.userIdentifier,
    );
    if (existing != null) {
      return _buildBoard(
        session,
        room,
        viewerId: auth.userIdentifier,
        dayKey: dayKey,
      );
    }

    await VowInvite.db.updateRow(
      session,
      invite.copyWith(useCount: invite.useCount + 1),
    );

    return _addMember(
      session,
      room: room,
      userId: auth.userIdentifier,
      displayName: name,
      dayKey: dayKey,
    );
  }

  Future<String> createInviteCode(
    Session session,
    int roomId, {
    int maxUses = 0,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in required.');
    }
    final mine = await _membershipOf(
      session,
      roomId: roomId,
      userId: auth.userIdentifier,
    );
    if (!_isAdminRole(mine?.role)) {
      throw VowException(message: 'Only admins can create invite codes.');
    }

    final code = _inviteCode();
    await VowInvite.db.insertRow(
      session,
      VowInvite(
        roomId: roomId,
        code: code,
        createdBy: auth.userIdentifier,
        createdAt: DateTime.now().toUtc(),
        maxUses: maxUses < 0 ? 0 : maxUses,
        useCount: 0,
      ),
    );
    return code;
  }

  String _inviteCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = DateTime.now().microsecondsSinceEpoch;
    final buf = StringBuffer();
    var x = rand;
    for (var i = 0; i < 8; i++) {
      buf.write(chars[x % chars.length]);
      x = (x * 1103515245 + 12345) & 0x7fffffff;
    }
    return buf.toString();
  }

  Future<JoinRequestPage> listJoinRequests(
    Session session,
    int roomId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in required.');
    }
    final mine = await _membershipOf(
      session,
      roomId: roomId,
      userId: auth.userIdentifier,
    );
    if (!_isAdminRole(mine?.role)) {
      throw VowException(message: 'Only admins can review join requests.');
    }

    final capped = _clampLimit(limit);
    final start = offset < 0 ? 0 : offset;
    final total = await JoinRequest.db.count(
      session,
      where: (t) => t.roomId.equals(roomId) & t.status.equals('pending'),
    );
    final items = await JoinRequest.db.find(
      session,
      where: (t) => t.roomId.equals(roomId) & t.status.equals('pending'),
      orderBy: (t) => t.createdAt,
      limit: capped,
      offset: start,
    );
    return JoinRequestPage(
      items: items,
      totalCount: total,
      limit: capped,
      offset: start,
      hasMore: start + items.length < total,
    );
  }

  Future<RoomBoard> reviewJoinRequest(
    Session session, {
    required int requestId,
    required bool approve,
    String? dayKey,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in required.');
    }
    final request = await JoinRequest.db.findById(session, requestId);
    if (request == null || request.status != 'pending') {
      throw VowException(message: 'Request not found.');
    }
    final mine = await _membershipOf(
      session,
      roomId: request.roomId,
      userId: auth.userIdentifier,
    );
    if (!_isAdminRole(mine?.role)) {
      throw VowException(message: 'Only admins can review join requests.');
    }

    final room = await VowRoom.db.findById(session, request.roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }

    if (!approve) {
      await JoinRequest.db.updateRow(
        session,
        request.copyWith(status: 'rejected'),
      );
      return _buildBoard(
        session,
        room,
        viewerId: auth.userIdentifier,
        dayKey: dayKey,
      );
    }

    await JoinRequest.db.updateRow(
      session,
      request.copyWith(status: 'approved'),
    );

    final already = await _membershipOf(
      session,
      roomId: request.roomId,
      userId: request.userId,
    );
    if (already == null) {
      await _addMember(
        session,
        room: room,
        userId: request.userId,
        displayName: request.displayName,
        dayKey: dayKey,
      );
    }
    final fresh = (await VowRoom.db.findById(session, request.roomId))!;
    return _buildBoard(
      session,
      fresh,
      viewerId: auth.userIdentifier,
      dayKey: dayKey,
    );
  }

  Future<MemberPage> listMembers(
    Session session,
    int roomId, {
    int limit = 30,
    int offset = 0,
    String? dayKey,
  }) async {
    final room = await VowRoom.db.findById(session, roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }
    final capped = _clampLimit(limit);
    final start = offset < 0 ? 0 : offset;
    final today = _resolveDayKey(dayKey);
    final total = await VowMembership.db.count(
      session,
      where: (t) => t.roomId.equals(roomId),
    );
    final memberships = await VowMembership.db.find(
      session,
      where: (t) => t.roomId.equals(roomId),
      orderBy: (t) => t.joinedAt,
      limit: capped,
      offset: start,
    );
    final checkIns = await VowCheckIn.db.find(
      session,
      where: (t) => t.roomId.equals(roomId) & t.dayKey.equals(today),
    );
    final byUser = {for (final c in checkIns) c.userId: c};
    final items = [
      for (final m in memberships)
        MemberDayStatus(
          userId: m.userId,
          displayName: m.displayName,
          role: m.role,
          kept: byUser[m.userId]?.kept,
          note: byUser[m.userId]?.note,
        ),
    ];
    return MemberPage(
      items: items,
      totalCount: total,
      limit: capped,
      offset: start,
      hasMore: start + items.length < total,
    );
  }

  Future<RoomBoard> getBoard(
    Session session,
    int roomId, {
    String? dayKey,
  }) async {
    final room = await VowRoom.db.findById(session, roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }
    final viewerId = session.authenticated?.userIdentifier ?? '';
    return _buildBoard(
      session,
      room,
      viewerId: viewerId,
      dayKey: dayKey,
    );
  }

  Stream<RoomBoard> watchBoard(
    Session session,
    int roomId, {
    String? dayKey,
  }) async* {
    final resolved = _resolveDayKey(dayKey);
    final viewerId = session.authenticated?.userIdentifier ?? '';

    Future<RoomBoard> load() async {
      final room = await VowRoom.db.findById(session, roomId);
      if (room == null) {
        throw VowException(message: 'Vow not found.');
      }
      return _buildBoard(
        session,
        room,
        viewerId: viewerId,
        dayKey: resolved,
      );
    }

    yield await load();

    final updates = session.messages.createStream<RoomBoard>(
      _boardChannel(roomId),
    );
    await for (final _ in updates) {
      yield await load();
    }
  }

  Future<RoomBoard> checkIn(
    Session session, {
    required int roomId,
    required bool kept,
    String? note,
    bool shareToFeed = false,
    String? dayKey,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to check in.');
    }

    final membership = await VowMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.roomId.equals(roomId) & t.userId.equals(auth.userIdentifier),
    );
    if (membership == null) {
      throw VowException(message: 'Join this vow before checking in.');
    }

    final room = await VowRoom.db.findById(session, roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }

    final today = _resolveDayKey(dayKey);
    final now = DateTime.now().toUtc();
    final trimmedNote = note?.trim().isEmpty == true ? null : note?.trim();
    final existing = await VowCheckIn.db.findFirstRow(
      session,
      where: (t) =>
          t.roomId.equals(roomId) &
          t.userId.equals(auth.userIdentifier) &
          t.dayKey.equals(today),
    );

    if (existing != null) {
      throw VowException(
        message: 'You already checked in today. Come back tomorrow.',
      );
    }

    await VowCheckIn.db.insertRow(
      session,
      VowCheckIn(
        roomId: roomId,
        userId: auth.userIdentifier,
        dayKey: today,
        kept: kept,
        note: trimmedNote,
        createdAt: now,
      ),
    );

    final verb = kept ? 'kept' : 'broke';
    final body = trimmedNote == null
        ? '${membership.displayName} $verb it today.'
        : '${membership.displayName} $verb it today — $trimmedNote';

    // Always lands in the room chat; public feed only when shareToFeed is true.
    await _postMessage(
      session,
      roomId: roomId,
      userId: auth.userIdentifier,
      displayName: membership.displayName,
      kind: kept ? 'kept' : 'broke',
      body: body,
      sharedToFeed: shareToFeed,
    );

    final board = await _buildBoard(
      session,
      room,
      viewerId: auth.userIdentifier,
      dayKey: today,
    );
    await _broadcastBoard(session, roomId, board);
    return board;
  }

  /// Open rooms: anyone can read chat. Other policies: members only.
  Future<void> _assertCanAccessChat(Session session, int roomId) async {
    final room = await VowRoom.db.findById(session, roomId);
    if (room == null) {
      throw VowException(message: 'Vow not found.');
    }
    if (room.joinPolicy == 'open') return;

    final viewerId = session.authenticated?.userIdentifier;
    if (viewerId == null) {
      throw VowException(message: 'Sign in and join to view this chat.');
    }
    final mine = await _membershipOf(
      session,
      roomId: roomId,
      userId: viewerId,
    );
    if (mine == null) {
      throw VowException(message: 'Join this vow to view the chat.');
    }
  }

  /// Latest messages in a room (oldest → newest for UI), paginated.
  Future<MessagePage> listMessages(
    Session session,
    int roomId, {
    int limit = 40,
    int offset = 0,
  }) async {
    await _assertCanAccessChat(session, roomId);
    final capped = _clampLimit(limit, max: 100);
    final start = offset < 0 ? 0 : offset;
    final total = await VowMessage.db.count(
      session,
      where: (t) => t.roomId.equals(roomId),
    );
    final rows = await VowMessage.db.find(
      session,
      where: (t) => t.roomId.equals(roomId),
      orderBy: (t) => t.createdAt,
      limit: capped,
      offset: start,
    );
    return MessagePage(
      items: rows,
      totalCount: total,
      limit: capped,
      offset: start,
      hasMore: start + rows.length < total,
    );
  }

  /// Live chat + activity stream (new messages only).
  Stream<VowMessage> watchChat(Session session, int roomId) async* {
    await _assertCanAccessChat(session, roomId);
    final live = session.messages.createStream<VowMessage>(
      _chatChannel(roomId),
    );
    await for (final message in live) {
      yield message;
    }
  }

  Future<VowMessage> sendMessage(
    Session session, {
    required int roomId,
    required String body,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to chat.');
    }
    final text = body.trim();
    if (text.isEmpty) {
      throw VowException(message: 'Message cannot be empty.');
    }
    if (text.length > 500) {
      throw VowException(message: 'Keep messages under 500 characters.');
    }

    final membership = await VowMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.roomId.equals(roomId) & t.userId.equals(auth.userIdentifier),
    );
    if (membership == null) {
      throw VowException(message: 'Join this vow before chatting.');
    }

    return _postMessage(
      session,
      roomId: roomId,
      userId: auth.userIdentifier,
      displayName: membership.displayName,
      kind: 'chat',
      body: text,
    );
  }

  /// Public pulse: only explicitly shared keep/break posts (never chat).
  Future<List<FeedItem>> listActivityFeed(
    Session session, {
    int limit = 40,
  }) async {
    await _seedIfEmpty(session);
    final capped = limit.clamp(1, 100);

    final messages = await VowMessage.db.find(
      session,
      where: (t) =>
          t.sharedToFeed.equals(true) &
          (t.kind.equals('kept') | t.kind.equals('broke')),
      orderBy: (t) => t.createdAt.desc(),
      limit: capped * 3,
    );
    if (messages.isEmpty) return [];

    final roomIdSet = messages.map((m) => m.roomId).toSet();
    final rooms = await VowRoom.db.find(
      session,
      where: (t) => t.id.inSet(roomIdSet) & t.isPublic.equals(true),
    );
    final byId = {for (final r in rooms) r.id!: r};

    final feed = <FeedItem>[];
    for (final m in messages) {
      final room = byId[m.roomId];
      if (room == null || m.id == null) continue;
      feed.add(
        FeedItem(
          messageId: m.id!,
          roomId: room.id!,
          roomTitle: room.title,
          roomCategory: room.category,
          displayName: m.displayName,
          kind: m.kind,
          body: m.body,
          createdAt: m.createdAt,
        ),
      );
      if (feed.length >= capped) break;
    }
    return feed;
  }

  /// Profile tab: rooms you joined + today’s keep/break tally.
  Future<KeptProfile> getMyProfile(
    Session session, {
    String? dayKey,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to view your profile.');
    }

    final memberships = await VowMembership.db.find(
      session,
      where: (t) => t.userId.equals(auth.userIdentifier),
      orderBy: (t) => t.joinedAt.desc(),
    );

    final globalName = await _globalName(session, auth.userIdentifier);
    final displayName = globalName != _label(auth.userIdentifier)
        ? globalName
        : (memberships.isNotEmpty ? memberships.first.displayName : globalName);

    if (memberships.isEmpty) {
      return KeptProfile(
        userId: auth.userIdentifier,
        displayName: displayName,
        memberRoomCount: 0,
        keptToday: 0,
        brokeToday: 0,
        pendingToday: 0,
        rooms: [],
      );
    }

    final roomIds = memberships.map((m) => m.roomId).toSet();
    final rooms = await VowRoom.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
    );
    rooms.sort((a, b) => b.memberCount.compareTo(a.memberCount));

    final today = _resolveDayKey(dayKey);
    final checkIns = await VowCheckIn.db.find(
      session,
      where: (t) =>
          t.userId.equals(auth.userIdentifier) & t.dayKey.equals(today),
    );
    final byRoom = {for (final c in checkIns) c.roomId: c};

    var kept = 0;
    var broken = 0;
    var pending = 0;
    for (final roomId in roomIds) {
      final c = byRoom[roomId];
      if (c == null) {
        pending++;
      } else if (c.kept) {
        kept++;
      } else {
        broken++;
      }
    }

    return KeptProfile(
      userId: auth.userIdentifier,
      displayName: displayName,
      memberRoomCount: rooms.length,
      keptToday: kept,
      brokeToday: broken,
      pendingToday: pending,
      rooms: rooms,
    );
  }

  /// Vows the viewer belongs to and has not checked in for on [dayKey].
  Future<List<OpenVow>> listOpenVows(
    Session session, {
    String? dayKey,
  }) async {
    final auth = session.authenticated;
    if (auth == null) return [];

    final today = _resolveDayKey(dayKey);
    final memberships = await VowMembership.db.find(
      session,
      where: (t) => t.userId.equals(auth.userIdentifier),
      orderBy: (t) => t.joinedAt,
    );
    if (memberships.isEmpty) return [];

    final roomIds = memberships.map((m) => m.roomId).toSet();
    final rooms = await VowRoom.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
    );
    final mine = await VowCheckIn.db.find(
      session,
      where: (t) =>
          t.userId.equals(auth.userIdentifier) & t.dayKey.equals(today),
    );
    final closed = mine.map((c) => c.roomId).toSet();
    final openRooms = rooms.where((r) => !closed.contains(r.id)).toList()
      ..sort((a, b) => a.title.compareTo(b.title));
    if (openRooms.isEmpty) return [];

    final open = <OpenVow>[];
    for (final room in openRooms) {
      final members = await VowMembership.db.find(
        session,
        where: (t) => t.roomId.equals(room.id!),
        orderBy: (t) => t.joinedAt,
      );
      final stats = await _tallyDay(
        session,
        roomId: room.id!,
        dayKey: today,
        memberships: members,
      );
      open.add(
        OpenVow(
          roomId: room.id!,
          title: room.title,
          rule: room.rule,
          category: room.category,
          memberTotal: members.length,
          keptCount: stats.kept,
          brokenCount: stats.broken,
          pendingCount: stats.pending,
        ),
      );
    }
    return open;
  }

  Future<void> _seedBlogIfEmpty(Session session) async {
    final existing = await BlogPost.db.count(session);
    if (existing > 0) return;

    final now = DateTime.now().toUtc();
    await BlogPost.db.insert(session, [
      BlogPost(
        slug: 'why-habits-stick',
        title: 'Why small habits beat big promises',
        excerpt:
            'Accountability works when the bar is clear and the day is short.',
        body:
            'Most people don’t fail because they lack motivation. They fail '
            'because the goal is vague and the feedback loop is invisible.\n\n'
            'A public vow fixes both. You pick one concrete daily rule. Your '
            'group sees whether you kept it. That social mirror is stronger '
            'than another private checklist.\n\n'
            'Start smaller than your ego wants. One liter of water. Twenty '
            'minutes of walking. Forty-five minutes of deep work. Kept is '
            'built for that kind of promise — not for life makeovers.',
        topic: 'habits',
        publishedAt: now.subtract(const Duration(hours: 5)),
      ),
      BlogPost(
        slug: 'water-matters',
        title: 'Why drinking water is a real vow',
        excerpt: 'Hydration looks boring until you track it with other people.',
        body:
            'Water is the underrated habit. No glamorous before/after photos. '
            'Just clearer focus, steadier energy, fewer afternoon crashes.\n\n'
            'The trick is specificity. “Drink more water” fails. “Finish 1L '
            'before dinner” can be kept or broken — which means it can be '
            'shared.\n\n'
            'When your room sees a green keep next to your name, the habit '
            'stops being optional. That is the whole point of Kept.',
        topic: 'water',
        publishedAt: now.subtract(const Duration(hours: 18)),
      ),
      BlogPost(
        slug: 'focus-block',
        title: 'Protect one focus block',
        excerpt:
            'Attention is the scarce resource. Guard forty-five minutes of it.',
        body:
            'Deep work doesn’t need an 8-hour monastery day. It needs one '
            'uninterrupted block that actually happens.\n\n'
            'Put your phone away. Close the chat tabs. Tell the room you’ll '
            'show up. Then check in when the block is done.\n\n'
            'If you broke it, say so. Honesty keeps the board trustworthy — '
            'and trust is what makes group accountability work.',
        topic: 'focus',
        publishedAt: now.subtract(const Duration(days: 1, hours: 2)),
      ),
      BlogPost(
        slug: 'move-daily',
        title: 'Movement is a mood tool',
        excerpt:
            'A short walk counts. The vow is showing up, not crushing a PR.',
        body:
            'You don’t need a perfect workout plan to feel different. You '
            'need a daily floor: twenty minutes of real movement.\n\n'
            'Outdoor walk. Treadmill. Easy jog. The rule matters more than '
            'the aesthetic.\n\n'
            'Join a move room. Keep the streak visible. Let the group carry '
            'you on the days your willpower is thin.',
        topic: 'move',
        publishedAt: now.subtract(const Duration(days: 2)),
      ),
    ]);
  }

  /// Mixed Instagram-style timeline: activity + habit articles (paginated).
  Future<HomeFeedPage> listHomeFeed(
    Session session, {
    int limit = 20,
    int offset = 0,
  }) async {
    await _seedIfEmpty(session);
    await _seedBlogIfEmpty(session);
    final capped = _clampLimit(limit);
    final start = offset < 0 ? 0 : offset;

    // Build a larger candidate window then page in memory — activity + articles.
    final activity = await listActivityFeed(session, limit: 80);
    final articles = await BlogPost.db.find(
      session,
      orderBy: (t) => t.publishedAt.desc(),
      limit: 24,
    );

    final draft = <HomeCard>[
      for (final a in activity)
        HomeCard(
          type: 'activity',
          createdAt: a.createdAt,
          activity: a,
          likeCount: 0,
          commentCount: 0,
          likedByMe: false,
          targetType: 'message',
          targetId: a.messageId,
        ),
      for (final post in articles)
        if (post.id != null)
          HomeCard(
            type: 'article',
            createdAt: post.publishedAt,
            article: post,
            likeCount: 0,
            commentCount: 0,
            likedByMe: false,
            targetType: 'article',
            targetId: post.id!,
          ),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final total = draft.length;
    final slice = start >= total
        ? <HomeCard>[]
        : draft.skip(start).take(capped).toList();
    final withSocial = await _attachSocial(session, slice);

    return HomeFeedPage(
      items: withSocial,
      totalCount: total,
      limit: capped,
      offset: start,
      hasMore: start + withSocial.length < total,
    );
  }

  Future<List<HomeCard>> _attachSocial(
    Session session,
    List<HomeCard> cards,
  ) async {
    if (cards.isEmpty) return cards;

    final messageIds = cards
        .where((c) => c.targetType == 'message')
        .map((c) => c.targetId)
        .toSet();
    final articleIds = cards
        .where((c) => c.targetType == 'article')
        .map((c) => c.targetId)
        .toSet();

    final likes = <FeedLike>[];
    final comments = <FeedComment>[];

    if (messageIds.isNotEmpty) {
      likes.addAll(
        await FeedLike.db.find(
          session,
          where: (t) =>
              t.targetType.equals('message') & t.targetId.inSet(messageIds),
        ),
      );
      comments.addAll(
        await FeedComment.db.find(
          session,
          where: (t) =>
              t.targetType.equals('message') & t.targetId.inSet(messageIds),
        ),
      );
    }
    if (articleIds.isNotEmpty) {
      likes.addAll(
        await FeedLike.db.find(
          session,
          where: (t) =>
              t.targetType.equals('article') & t.targetId.inSet(articleIds),
        ),
      );
      comments.addAll(
        await FeedComment.db.find(
          session,
          where: (t) =>
              t.targetType.equals('article') & t.targetId.inSet(articleIds),
        ),
      );
    }

    final viewerId = session.authenticated?.userIdentifier;
    final likeCount = <String, int>{};
    final commentCount = <String, int>{};
    final likedByMe = <String>{};

    for (final like in likes) {
      final key = '${like.targetType}:${like.targetId}';
      likeCount[key] = (likeCount[key] ?? 0) + 1;
      if (viewerId != null && like.userId == viewerId) {
        likedByMe.add(key);
      }
    }
    for (final comment in comments) {
      final key = '${comment.targetType}:${comment.targetId}';
      commentCount[key] = (commentCount[key] ?? 0) + 1;
    }

    return [
      for (final card in cards)
        card.copyWith(
          likeCount: likeCount['${card.targetType}:${card.targetId}'] ?? 0,
          commentCount:
              commentCount['${card.targetType}:${card.targetId}'] ?? 0,
          likedByMe: likedByMe.contains('${card.targetType}:${card.targetId}'),
        ),
    ];
  }

  Future<void> _assertSocialTarget(
    Session session, {
    required String targetType,
    required int targetId,
  }) async {
    if (targetType != 'message') {
      throw VowException(
        message: 'Likes and comments are only for shared keep/break posts.',
      );
    }
    final message = await VowMessage.db.findById(session, targetId);
    if (message == null ||
        !message.sharedToFeed ||
        (message.kind != 'kept' && message.kind != 'broke')) {
      throw VowException(message: 'Post not found.');
    }
  }

  Future<String> _displayNameFor(Session session, String userId) async {
    final global = await _globalName(session, userId);
    if (global != _label(userId)) return global;
    final membership = await VowMembership.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.joinedAt.desc(),
    );
    return membership?.displayName ?? global;
  }

  /// Toggle like on a shared keep/break post (not journal articles).
  Future<HomeCard> toggleLike(
    Session session, {
    required String targetType,
    required int targetId,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to like posts.');
    }
    await _assertSocialTarget(
      session,
      targetType: targetType,
      targetId: targetId,
    );

    final existing = await FeedLike.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(auth.userIdentifier) &
          t.targetType.equals(targetType) &
          t.targetId.equals(targetId),
    );

    if (existing != null) {
      await FeedLike.db.deleteRow(session, existing);
    } else {
      await FeedLike.db.insertRow(
        session,
        FeedLike(
          userId: auth.userIdentifier,
          targetType: targetType,
          targetId: targetId,
          createdAt: DateTime.now().toUtc(),
        ),
      );
    }

    return _cardSnapshot(session, targetType: targetType, targetId: targetId);
  }

  Future<HomeCard> _cardSnapshot(
    Session session, {
    required String targetType,
    required int targetId,
  }) async {
    if (targetType != 'message') {
      throw VowException(message: 'Post not found.');
    }
    final message = await VowMessage.db.findById(session, targetId);
    if (message == null || !message.sharedToFeed) {
      throw VowException(message: 'Post not found.');
    }
    final room = await VowRoom.db.findById(session, message.roomId);
    if (room == null || !room.isPublic) {
      throw VowException(message: 'Post not found.');
    }
    final card = HomeCard(
      type: 'activity',
      createdAt: message.createdAt,
      activity: FeedItem(
        messageId: message.id!,
        roomId: room.id!,
        roomTitle: room.title,
        roomCategory: room.category,
        displayName: message.displayName,
        kind: message.kind,
        body: message.body,
        createdAt: message.createdAt,
      ),
      likeCount: 0,
      commentCount: 0,
      likedByMe: false,
      targetType: 'message',
      targetId: targetId,
    );
    return (await _attachSocial(session, [card])).first;
  }

  Future<FeedCommentPage> listComments(
    Session session, {
    required String targetType,
    required int targetId,
    int limit = 30,
    int offset = 0,
  }) async {
    await _assertSocialTarget(
      session,
      targetType: targetType,
      targetId: targetId,
    );
    final capped = _clampLimit(limit);
    final start = offset < 0 ? 0 : offset;
    final total = await FeedComment.db.count(
      session,
      where: (t) =>
          t.targetType.equals(targetType) & t.targetId.equals(targetId),
    );
    final items = await FeedComment.db.find(
      session,
      where: (t) =>
          t.targetType.equals(targetType) & t.targetId.equals(targetId),
      orderBy: (t) => t.createdAt,
      limit: capped,
      offset: start,
    );
    return FeedCommentPage(
      items: items,
      totalCount: total,
      limit: capped,
      offset: start,
      hasMore: start + items.length < total,
    );
  }

  Future<FeedComment> addComment(
    Session session, {
    required String targetType,
    required int targetId,
    required String body,
  }) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw VowException(message: 'Sign in to comment.');
    }
    await _assertSocialTarget(
      session,
      targetType: targetType,
      targetId: targetId,
    );

    final text = body.trim();
    if (text.isEmpty) {
      throw VowException(message: 'Comment cannot be empty.');
    }
    if (text.length > 400) {
      throw VowException(message: 'Keep comments under 400 characters.');
    }

    final name = await _displayNameFor(session, auth.userIdentifier);
    return FeedComment.db.insertRow(
      session,
      FeedComment(
        userId: auth.userIdentifier,
        displayName: name,
        targetType: targetType,
        targetId: targetId,
        body: text,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<BlogPost> getBlogPost(Session session, String slug) async {
    await _seedBlogIfEmpty(session);
    final post = await BlogPost.db.findFirstRow(
      session,
      where: (t) => t.slug.equals(slug),
    );
    if (post == null) {
      throw VowException(message: 'Article not found.');
    }
    return post;
  }
}
