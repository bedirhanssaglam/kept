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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:kept_client/src/protocol/greetings/greeting.dart' as _iuljije8;
import 'package:kept_client/src/protocol/vows/blog_post.dart' as _i67mpgzs;
import 'package:kept_client/src/protocol/vows/feed_comment.dart' as _i8vdcaj8;
import 'package:kept_client/src/protocol/vows/feed_comment_page.dart'
    as _igqbfxbc;
import 'package:kept_client/src/protocol/vows/feed_item.dart' as _i6pzb9we;
import 'package:kept_client/src/protocol/vows/home_card.dart' as _iiywv5iv;
import 'package:kept_client/src/protocol/vows/home_feed_page.dart' as _iz9ecaq5;
import 'package:kept_client/src/protocol/vows/join_request.dart' as _ik83ghu5;
import 'package:kept_client/src/protocol/vows/join_request_page.dart'
    as _iaf12wny;
import 'package:kept_client/src/protocol/vows/kept_profile.dart' as _i0nn5j0b;
import 'package:kept_client/src/protocol/vows/member_page.dart' as _iqca1nbt;
import 'package:kept_client/src/protocol/vows/message_page.dart' as _i534l2u7;
import 'package:kept_client/src/protocol/vows/open_vow.dart' as _i7afbb30;
import 'package:kept_client/src/protocol/vows/room_board.dart' as _ii8jaug4;
import 'package:kept_client/src/protocol/vows/vow_message.dart' as _ih997mkf;
import 'package:kept_client/src/protocol/vows/vow_room.dart' as _ipjsdrtd;
import 'package:kept_client/src/protocol/vows/vow_room_page.dart' as _ijwqtmhk;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Starts registration, but surfaces an explicit error when the email is
  /// already taken (Serverpod's default silently returns a dummy request id).
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Exposes profile editing (username, full name, image) to the Flutter app.
/// {@category Endpoint}
class EndpointUserProfileEdit extends _iacc.EndpointUserProfileEditBase {
  EndpointUserProfileEdit(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfileEdit';

  @override
  _ida.Future<_iacc.UserProfileModel> changeUserName(String? userName) =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'changeUserName',
        {'userName': userName},
      );

  /// Removes the user's uploaded image, setting it to null.
  ///
  /// The client should handle displaying a placeholder for users without images.
  @override
  _ida.Future<_iacc.UserProfileModel> removeUserImage() =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'removeUserImage',
        {},
      );

  /// Sets a new user image for the signed in user.
  @override
  _ida.Future<_iacc.UserProfileModel> setUserImage(_idt.ByteData image) =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'setUserImage',
        {'image': image},
      );

  /// Changes the full name of a user.
  @override
  _ida.Future<_iacc.UserProfileModel> changeFullName(String? fullName) =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'changeFullName',
        {'fullName': fullName},
      );

  /// Returns the user profile of the current user.
  @override
  _ida.Future<_iacc.UserProfileModel> get() =>
      caller.callServerEndpoint<_iacc.UserProfileModel>(
        'userProfileEdit',
        'get',
        {},
      );
}

/// Public username helpers (available before the user finishes registration).
/// {@category Endpoint}
class EndpointUsername extends _isc.EndpointRef {
  EndpointUsername(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'username';

  /// Validates format and uniqueness. Throws [UsernameException] on failure.
  _ida.Future<void> assertAvailable(String userName) =>
      caller.callServerEndpoint<void>(
        'username',
        'assertAvailable',
        {'userName': userName},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_iuljije8.Greeting> hello(String name) =>
      caller.callServerEndpoint<_iuljije8.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Vow rooms, daily keep/break, live boards, and room chat.
/// {@category Endpoint}
class EndpointVow extends _isc.EndpointRef {
  EndpointVow(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'vow';

  _ida.Future<_ijwqtmhk.VowRoomPage> listPublicRooms({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<_ijwqtmhk.VowRoomPage>(
    'vow',
    'listPublicRooms',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_ipjsdrtd.VowRoom> createRoom({
    required String title,
    required String rule,
    required String category,
    String? displayName,
    required bool isPublic,
    required String joinPolicy,
  }) => caller.callServerEndpoint<_ipjsdrtd.VowRoom>(
    'vow',
    'createRoom',
    {
      'title': title,
      'rule': rule,
      'category': category,
      'displayName': displayName,
      'isPublic': isPublic,
      'joinPolicy': joinPolicy,
    },
  );

  /// Join an open room immediately. Other policies use requestJoin / joinWithInvite.
  _ida.Future<_ii8jaug4.RoomBoard> joinRoom(
    int roomId, {
    String? displayName,
    String? dayKey,
  }) => caller.callServerEndpoint<_ii8jaug4.RoomBoard>(
    'vow',
    'joinRoom',
    {
      'roomId': roomId,
      'displayName': displayName,
      'dayKey': dayKey,
    },
  );

  _ida.Future<_ik83ghu5.JoinRequest> requestJoin(
    int roomId, {
    String? displayName,
  }) => caller.callServerEndpoint<_ik83ghu5.JoinRequest>(
    'vow',
    'requestJoin',
    {
      'roomId': roomId,
      'displayName': displayName,
    },
  );

  _ida.Future<_ii8jaug4.RoomBoard> joinWithInvite({
    required String code,
    String? displayName,
    String? dayKey,
  }) => caller.callServerEndpoint<_ii8jaug4.RoomBoard>(
    'vow',
    'joinWithInvite',
    {
      'code': code,
      'displayName': displayName,
      'dayKey': dayKey,
    },
  );

  _ida.Future<String> createInviteCode(
    int roomId, {
    required int maxUses,
  }) => caller.callServerEndpoint<String>(
    'vow',
    'createInviteCode',
    {
      'roomId': roomId,
      'maxUses': maxUses,
    },
  );

  _ida.Future<_iaf12wny.JoinRequestPage> listJoinRequests(
    int roomId, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<_iaf12wny.JoinRequestPage>(
    'vow',
    'listJoinRequests',
    {
      'roomId': roomId,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_ii8jaug4.RoomBoard> reviewJoinRequest({
    required int requestId,
    required bool approve,
    String? dayKey,
  }) => caller.callServerEndpoint<_ii8jaug4.RoomBoard>(
    'vow',
    'reviewJoinRequest',
    {
      'requestId': requestId,
      'approve': approve,
      'dayKey': dayKey,
    },
  );

  _ida.Future<_iqca1nbt.MemberPage> listMembers(
    int roomId, {
    required int limit,
    required int offset,
    String? dayKey,
  }) => caller.callServerEndpoint<_iqca1nbt.MemberPage>(
    'vow',
    'listMembers',
    {
      'roomId': roomId,
      'limit': limit,
      'offset': offset,
      'dayKey': dayKey,
    },
  );

  _ida.Future<_ii8jaug4.RoomBoard> getBoard(
    int roomId, {
    String? dayKey,
  }) => caller.callServerEndpoint<_ii8jaug4.RoomBoard>(
    'vow',
    'getBoard',
    {
      'roomId': roomId,
      'dayKey': dayKey,
    },
  );

  _ida.Stream<_ii8jaug4.RoomBoard> watchBoard(
    int roomId, {
    String? dayKey,
  }) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ii8jaug4.RoomBoard>,
        _ii8jaug4.RoomBoard
      >(
        'vow',
        'watchBoard',
        {
          'roomId': roomId,
          'dayKey': dayKey,
        },
        {},
      );

  _ida.Future<_ii8jaug4.RoomBoard> checkIn({
    required int roomId,
    required bool kept,
    String? note,
    required bool shareToFeed,
    String? dayKey,
  }) => caller.callServerEndpoint<_ii8jaug4.RoomBoard>(
    'vow',
    'checkIn',
    {
      'roomId': roomId,
      'kept': kept,
      'note': note,
      'shareToFeed': shareToFeed,
      'dayKey': dayKey,
    },
  );

  /// Latest messages in a room (oldest → newest for UI), paginated.
  _ida.Future<_i534l2u7.MessagePage> listMessages(
    int roomId, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<_i534l2u7.MessagePage>(
    'vow',
    'listMessages',
    {
      'roomId': roomId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Live chat + activity stream (new messages only).
  _ida.Stream<_ih997mkf.VowMessage> watchChat(int roomId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ih997mkf.VowMessage>,
        _ih997mkf.VowMessage
      >(
        'vow',
        'watchChat',
        {'roomId': roomId},
        {},
      );

  _ida.Future<_ih997mkf.VowMessage> sendMessage({
    required int roomId,
    required String body,
  }) => caller.callServerEndpoint<_ih997mkf.VowMessage>(
    'vow',
    'sendMessage',
    {
      'roomId': roomId,
      'body': body,
    },
  );

  /// Public pulse: only explicitly shared keep/break posts (never chat).
  _ida.Future<List<_i6pzb9we.FeedItem>> listActivityFeed({
    required int limit,
  }) => caller.callServerEndpoint<List<_i6pzb9we.FeedItem>>(
    'vow',
    'listActivityFeed',
    {'limit': limit},
  );

  /// Profile tab: rooms you joined + today’s keep/break tally.
  _ida.Future<_i0nn5j0b.KeptProfile> getMyProfile({String? dayKey}) =>
      caller.callServerEndpoint<_i0nn5j0b.KeptProfile>(
        'vow',
        'getMyProfile',
        {'dayKey': dayKey},
      );

  /// Vows the viewer belongs to and has not checked in for on [dayKey].
  _ida.Future<List<_i7afbb30.OpenVow>> listOpenVows({String? dayKey}) =>
      caller.callServerEndpoint<List<_i7afbb30.OpenVow>>(
        'vow',
        'listOpenVows',
        {'dayKey': dayKey},
      );

  /// Mixed Instagram-style timeline: activity + habit articles (paginated).
  _ida.Future<_iz9ecaq5.HomeFeedPage> listHomeFeed({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<_iz9ecaq5.HomeFeedPage>(
    'vow',
    'listHomeFeed',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Toggle like on a shared keep/break post (not journal articles).
  _ida.Future<_iiywv5iv.HomeCard> toggleLike({
    required String targetType,
    required int targetId,
  }) => caller.callServerEndpoint<_iiywv5iv.HomeCard>(
    'vow',
    'toggleLike',
    {
      'targetType': targetType,
      'targetId': targetId,
    },
  );

  _ida.Future<_igqbfxbc.FeedCommentPage> listComments({
    required String targetType,
    required int targetId,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<_igqbfxbc.FeedCommentPage>(
    'vow',
    'listComments',
    {
      'targetType': targetType,
      'targetId': targetId,
      'limit': limit,
      'offset': offset,
    },
  );

  _ida.Future<_i8vdcaj8.FeedComment> addComment({
    required String targetType,
    required int targetId,
    required String body,
  }) => caller.callServerEndpoint<_i8vdcaj8.FeedComment>(
    'vow',
    'addComment',
    {
      'targetType': targetType,
      'targetId': targetId,
      'body': body,
    },
  );

  _ida.Future<_i67mpgzs.BlogPost> getBlogPost(String slug) =>
      caller.callServerEndpoint<_i67mpgzs.BlogPost>(
        'vow',
        'getBlogPost',
        {'slug': slug},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    userProfileEdit = EndpointUserProfileEdit(this);
    username = EndpointUsername(this);
    greeting = EndpointGreeting(this);
    vow = EndpointVow(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointUserProfileEdit userProfileEdit;

  late final EndpointUsername username;

  late final EndpointGreeting greeting;

  late final EndpointVow vow;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'userProfileEdit': userProfileEdit,
    'username': username,
    'greeting': greeting,
    'vow': vow,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
