import 'package:kept_client/kept_client.dart';

import '../client.dart' as app;
import '../core/time/kept_day.dart';

/// Thin wrapper around the generated Serverpod client.
class VowRepository {
  VowRepository({Client? client}) : _client = client ?? app.client;

  final Client _client;

  Future<VowRoomPage> listPublicRooms({int limit = 20, int offset = 0}) {
    return _client.vow.listPublicRooms(limit: limit, offset: offset);
  }

  Future<HomeFeedPage> listHomeFeed({int limit = 20, int offset = 0}) {
    return _client.vow.listHomeFeed(limit: limit, offset: offset);
  }

  Future<HomeCard> toggleLike({
    required String targetType,
    required int targetId,
  }) {
    return _client.vow.toggleLike(
      targetType: targetType,
      targetId: targetId,
    );
  }

  Future<FeedCommentPage> listComments({
    required String targetType,
    required int targetId,
    int limit = 30,
    int offset = 0,
  }) {
    return _client.vow.listComments(
      targetType: targetType,
      targetId: targetId,
      limit: limit,
      offset: offset,
    );
  }

  Future<FeedComment> addComment({
    required String targetType,
    required int targetId,
    required String body,
  }) {
    return _client.vow.addComment(
      targetType: targetType,
      targetId: targetId,
      body: body,
    );
  }

  Future<BlogPost> getBlogPost(String slug) => _client.vow.getBlogPost(slug);

  Future<KeptProfile> getMyProfile() =>
      _client.vow.getMyProfile(dayKey: KeptDay.key());

  Future<List<OpenVow>> listOpenVows() =>
      _client.vow.listOpenVows(dayKey: KeptDay.key());

  Future<VowRoom> createRoom({
    required String title,
    required String rule,
    required String category,
    String? displayName,
    bool isPublic = true,
    String joinPolicy = 'open',
  }) {
    return _client.vow.createRoom(
      title: title,
      rule: rule,
      category: category,
      displayName: displayName,
      isPublic: isPublic,
      joinPolicy: joinPolicy,
    );
  }

  Future<RoomBoard> joinRoom(int roomId, {String? displayName}) {
    return _client.vow.joinRoom(
      roomId,
      displayName: displayName,
      dayKey: KeptDay.key(),
    );
  }

  Future<JoinRequest> requestJoin(int roomId, {String? displayName}) {
    return _client.vow.requestJoin(roomId, displayName: displayName);
  }

  Future<RoomBoard> joinWithInvite({
    required String code,
    String? displayName,
  }) {
    return _client.vow.joinWithInvite(
      code: code,
      displayName: displayName,
      dayKey: KeptDay.key(),
    );
  }

  Future<String> createInviteCode(int roomId, {int maxUses = 0}) {
    return _client.vow.createInviteCode(roomId, maxUses: maxUses);
  }

  Future<JoinRequestPage> listJoinRequests(
    int roomId, {
    int limit = 20,
    int offset = 0,
  }) {
    return _client.vow.listJoinRequests(roomId, limit: limit, offset: offset);
  }

  Future<RoomBoard> reviewJoinRequest({
    required int requestId,
    required bool approve,
  }) {
    return _client.vow.reviewJoinRequest(
      requestId: requestId,
      approve: approve,
      dayKey: KeptDay.key(),
    );
  }

  Future<MemberPage> listMembers(
    int roomId, {
    int limit = 30,
    int offset = 0,
  }) {
    return _client.vow.listMembers(
      roomId,
      limit: limit,
      offset: offset,
      dayKey: KeptDay.key(),
    );
  }

  Future<RoomBoard> getBoard(int roomId) =>
      _client.vow.getBoard(roomId, dayKey: KeptDay.key());

  Stream<RoomBoard> watchBoard(int roomId) =>
      _client.vow.watchBoard(roomId, dayKey: KeptDay.key());

  Future<RoomBoard> checkIn({
    required int roomId,
    required bool kept,
    String? note,
    bool shareToFeed = false,
  }) {
    return _client.vow.checkIn(
      roomId: roomId,
      kept: kept,
      note: note,
      shareToFeed: shareToFeed,
      dayKey: KeptDay.key(),
    );
  }

  Future<MessagePage> listMessages(
    int roomId, {
    int limit = 40,
    int offset = 0,
  }) {
    return _client.vow.listMessages(roomId, limit: limit, offset: offset);
  }

  Stream<VowMessage> watchChat(int roomId) => _client.vow.watchChat(roomId);

  Future<VowMessage> sendMessage({
    required int roomId,
    required String body,
  }) {
    return _client.vow.sendMessage(roomId: roomId, body: body);
  }
}
