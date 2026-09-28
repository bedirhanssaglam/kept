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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../endpoints/auth/email_idp_endpoint.dart' as _i63m0k53;
import '../endpoints/auth/jwt_refresh_endpoint.dart' as _i0byai1f;
import '../endpoints/auth/user_profile_edit_endpoint.dart' as _iczj7nhy;
import '../endpoints/auth/username_endpoint.dart' as _imotpk2a;
import '../endpoints/greeting_endpoint.dart' as _imlzn9oq;
import '../endpoints/vow_endpoint.dart' as _i127k99a;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _i63m0k53.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i0byai1f.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'userProfileEdit': _iczj7nhy.UserProfileEditEndpoint()
        ..initialize(
          server,
          'userProfileEdit',
          null,
        ),
      'username': _imotpk2a.UsernameEndpoint()
        ..initialize(
          server,
          'username',
          null,
        ),
      'greeting': _imlzn9oq.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'vow': _i127k99a.VowEndpoint()
        ..initialize(
          server,
          'vow',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i63m0k53.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _i0byai1f.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['userProfileEdit'] = _is.EndpointConnector(
      name: 'userProfileEdit',
      endpoint: endpoints['userProfileEdit']!,
      methodConnectors: {
        'changeUserName': _is.MethodConnector(
          name: 'changeUserName',
          params: {
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iczj7nhy.UserProfileEditEndpoint)
                      .changeUserName(
                        session,
                        params['userName'],
                      ),
        ),
        'removeUserImage': _is.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iczj7nhy.UserProfileEditEndpoint)
                      .removeUserImage(session),
        ),
        'setUserImage': _is.MethodConnector(
          name: 'setUserImage',
          params: {
            'image': _is.ParameterDescription(
              name: 'image',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iczj7nhy.UserProfileEditEndpoint)
                      .setUserImage(
                        session,
                        params['image'],
                      ),
        ),
        'changeFullName': _is.MethodConnector(
          name: 'changeFullName',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iczj7nhy.UserProfileEditEndpoint)
                      .changeFullName(
                        session,
                        params['fullName'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit']
                          as _iczj7nhy.UserProfileEditEndpoint)
                      .get(session),
        ),
      },
    );
    connectors['username'] = _is.EndpointConnector(
      name: 'username',
      endpoint: endpoints['username']!,
      methodConnectors: {
        'assertAvailable': _is.MethodConnector(
          name: 'assertAvailable',
          params: {
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['username'] as _imotpk2a.UsernameEndpoint)
                  .assertAvailable(
                    session,
                    params['userName'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _imlzn9oq.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['vow'] = _is.EndpointConnector(
      name: 'vow',
      endpoint: endpoints['vow']!,
      methodConnectors: {
        'listPublicRooms': _is.MethodConnector(
          name: 'listPublicRooms',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listPublicRooms(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'createRoom': _is.MethodConnector(
          name: 'createRoom',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'rule': _is.ParameterDescription(
              name: 'rule',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'isPublic': _is.ParameterDescription(
              name: 'isPublic',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'joinPolicy': _is.ParameterDescription(
              name: 'joinPolicy',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'durationDays': _is.ParameterDescription(
              name: 'durationDays',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'startsOn': _is.ParameterDescription(
              name: 'startsOn',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['vow'] as _i127k99a.VowEndpoint).createRoom(
                session,
                title: params['title'],
                rule: params['rule'],
                category: params['category'],
                displayName: params['displayName'],
                isPublic: params['isPublic'],
                joinPolicy: params['joinPolicy'],
                durationDays: params['durationDays'],
                startsOn: params['startsOn'],
              ),
        ),
        'joinRoom': _is.MethodConnector(
          name: 'joinRoom',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['vow'] as _i127k99a.VowEndpoint).joinRoom(
                session,
                params['roomId'],
                displayName: params['displayName'],
                dayKey: params['dayKey'],
              ),
        ),
        'requestJoin': _is.MethodConnector(
          name: 'requestJoin',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).requestJoin(
                    session,
                    params['roomId'],
                    displayName: params['displayName'],
                  ),
        ),
        'joinWithInvite': _is.MethodConnector(
          name: 'joinWithInvite',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).joinWithInvite(
                    session,
                    code: params['code'],
                    displayName: params['displayName'],
                    dayKey: params['dayKey'],
                  ),
        ),
        'createInviteCode': _is.MethodConnector(
          name: 'createInviteCode',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'maxUses': _is.ParameterDescription(
              name: 'maxUses',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).createInviteCode(
                    session,
                    params['roomId'],
                    maxUses: params['maxUses'],
                  ),
        ),
        'listJoinRequests': _is.MethodConnector(
          name: 'listJoinRequests',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listJoinRequests(
                    session,
                    params['roomId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'reviewJoinRequest': _is.MethodConnector(
          name: 'reviewJoinRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approve': _is.ParameterDescription(
              name: 'approve',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).reviewJoinRequest(
                    session,
                    requestId: params['requestId'],
                    approve: params['approve'],
                    dayKey: params['dayKey'],
                  ),
        ),
        'listMembers': _is.MethodConnector(
          name: 'listMembers',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listMembers(
                    session,
                    params['roomId'],
                    limit: params['limit'],
                    offset: params['offset'],
                    dayKey: params['dayKey'],
                  ),
        ),
        'getBoard': _is.MethodConnector(
          name: 'getBoard',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['vow'] as _i127k99a.VowEndpoint).getBoard(
                session,
                params['roomId'],
                dayKey: params['dayKey'],
              ),
        ),
        'checkIn': _is.MethodConnector(
          name: 'checkIn',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'kept': _is.ParameterDescription(
              name: 'kept',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'shareToFeed': _is.ParameterDescription(
              name: 'shareToFeed',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['vow'] as _i127k99a.VowEndpoint).checkIn(
                session,
                roomId: params['roomId'],
                kept: params['kept'],
                note: params['note'],
                shareToFeed: params['shareToFeed'],
                dayKey: params['dayKey'],
              ),
        ),
        'listMessages': _is.MethodConnector(
          name: 'listMessages',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listMessages(
                    session,
                    params['roomId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'sendMessage': _is.MethodConnector(
          name: 'sendMessage',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'body': _is.ParameterDescription(
              name: 'body',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).sendMessage(
                    session,
                    roomId: params['roomId'],
                    body: params['body'],
                  ),
        ),
        'listActivityFeed': _is.MethodConnector(
          name: 'listActivityFeed',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listActivityFeed(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).getMyProfile(
                    session,
                    dayKey: params['dayKey'],
                  ),
        ),
        'listOpenVows': _is.MethodConnector(
          name: 'listOpenVows',
          params: {
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listOpenVows(
                    session,
                    dayKey: params['dayKey'],
                  ),
        ),
        'listHomeFeed': _is.MethodConnector(
          name: 'listHomeFeed',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listHomeFeed(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'toggleLike': _is.MethodConnector(
          name: 'toggleLike',
          params: {
            'targetType': _is.ParameterDescription(
              name: 'targetType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetId': _is.ParameterDescription(
              name: 'targetId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['vow'] as _i127k99a.VowEndpoint).toggleLike(
                session,
                targetType: params['targetType'],
                targetId: params['targetId'],
              ),
        ),
        'listComments': _is.MethodConnector(
          name: 'listComments',
          params: {
            'targetType': _is.ParameterDescription(
              name: 'targetType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetId': _is.ParameterDescription(
              name: 'targetId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).listComments(
                    session,
                    targetType: params['targetType'],
                    targetId: params['targetId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'addComment': _is.MethodConnector(
          name: 'addComment',
          params: {
            'targetType': _is.ParameterDescription(
              name: 'targetType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'targetId': _is.ParameterDescription(
              name: 'targetId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'body': _is.ParameterDescription(
              name: 'body',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['vow'] as _i127k99a.VowEndpoint).addComment(
                session,
                targetType: params['targetType'],
                targetId: params['targetId'],
                body: params['body'],
              ),
        ),
        'getBlogPost': _is.MethodConnector(
          name: 'getBlogPost',
          params: {
            'slug': _is.ParameterDescription(
              name: 'slug',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['vow'] as _i127k99a.VowEndpoint).getBlogPost(
                    session,
                    params['slug'],
                  ),
        ),
        'watchBoard': _is.MethodStreamConnector(
          name: 'watchBoard',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'dayKey': _is.ParameterDescription(
              name: 'dayKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['vow'] as _i127k99a.VowEndpoint).watchBoard(
                session,
                params['roomId'],
                dayKey: params['dayKey'],
              ),
        ),
        'watchChat': _is.MethodStreamConnector(
          name: 'watchChat',
          params: {
            'roomId': _is.ParameterDescription(
              name: 'roomId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['vow'] as _i127k99a.VowEndpoint).watchChat(
                session,
                params['roomId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
