/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:kept_server/src/generated/vows/feed_item.dart' as _iin21y76;
import 'package:kept_server/src/generated/vows/open_vow.dart' as _iw6g57rx;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'auth/email_already_registered_exception.dart' as _ifkvqf5h;
import 'auth/username_exception.dart' as _i6auzokb;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'vows/blog_post.dart' as _ibeas2fs;
import 'vows/feed_comment.dart' as _i5srmehb;
import 'vows/feed_comment_page.dart' as _i2g4ey88;
import 'vows/feed_item.dart' as _i3210eu2;
import 'vows/feed_like.dart' as _itnngz98;
import 'vows/home_card.dart' as _im0nwja5;
import 'vows/home_feed_page.dart' as _iyfj34j3;
import 'vows/join_request.dart' as _iabb3f3a;
import 'vows/join_request_page.dart' as _i5vd9zri;
import 'vows/kept_profile.dart' as _ixf78lra;
import 'vows/member_day_status.dart' as _i65tc21s;
import 'vows/member_page.dart' as _iy6vp3i6;
import 'vows/message_page.dart' as _i4vydc8o;
import 'vows/open_vow.dart' as _i6ufruid;
import 'vows/room_board.dart' as _idd0e55h;
import 'vows/vow_check_in.dart' as _iiejv3p6;
import 'vows/vow_exception.dart' as _iz96iiq6;
import 'vows/vow_invite.dart' as _iwq3va4n;
import 'vows/vow_membership.dart' as _imwe36zt;
import 'vows/vow_message.dart' as _ip5iwkae;
import 'vows/vow_room.dart' as _i4wblqhy;
import 'vows/vow_room_page.dart' as _ioquy3ul;
export 'auth/email_already_registered_exception.dart';
export 'auth/username_exception.dart';
export 'greetings/greeting.dart';
export 'vows/blog_post.dart';
export 'vows/feed_comment.dart';
export 'vows/feed_comment_page.dart';
export 'vows/feed_item.dart';
export 'vows/feed_like.dart';
export 'vows/home_card.dart';
export 'vows/home_feed_page.dart';
export 'vows/join_request.dart';
export 'vows/join_request_page.dart';
export 'vows/kept_profile.dart';
export 'vows/member_day_status.dart';
export 'vows/member_page.dart';
export 'vows/message_page.dart';
export 'vows/open_vow.dart';
export 'vows/room_board.dart';
export 'vows/vow_check_in.dart';
export 'vows/vow_exception.dart';
export 'vows/vow_invite.dart';
export 'vows/vow_membership.dart';
export 'vows/vow_message.dart';
export 'vows/vow_room.dart';
export 'vows/vow_room_page.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'blog_post',
      dartName: 'BlogPost',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'slug',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'excerpt',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'topic',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'publishedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'blog_post_slug_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feed_comment',
      dartName: 'FeedComment',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'feed_comment_target_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feed_like',
      dartName: 'FeedLike',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'feed_like_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'feed_like_target_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'join_request',
      dartName: 'JoinRequest',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'join_request_room_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'join_request_room_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vow_check_in',
      dartName: 'VowCheckIn',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dayKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'kept',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'note',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vow_invite',
      dartName: 'VowInvite',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'maxUses',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'useCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'vow_invite_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'vow_invite_room_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'roomId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vow_membership',
      dartName: 'VowMembership',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'member\'',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vow_message',
      dartName: 'VowMessage',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'roomId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sharedToFeed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vow_room',
      dartName: 'VowRoom',
      schema: 'public',
      module: 'kept',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'rule',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isPublic',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'joinPolicy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'open\'',
        ),
        _isp.ColumnDefinition(
          name: 'isOfficial',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'creatorId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'memberCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ifkvqf5h.EmailAlreadyRegisteredException) {
      return _ifkvqf5h.EmailAlreadyRegisteredException.fromJson(data) as T;
    }
    if (t == _i6auzokb.UsernameException) {
      return _i6auzokb.UsernameException.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ibeas2fs.BlogPost) {
      return _ibeas2fs.BlogPost.fromJson(data) as T;
    }
    if (t == _i5srmehb.FeedComment) {
      return _i5srmehb.FeedComment.fromJson(data) as T;
    }
    if (t == _i2g4ey88.FeedCommentPage) {
      return _i2g4ey88.FeedCommentPage.fromJson(data) as T;
    }
    if (t == _i3210eu2.FeedItem) {
      return _i3210eu2.FeedItem.fromJson(data) as T;
    }
    if (t == _itnngz98.FeedLike) {
      return _itnngz98.FeedLike.fromJson(data) as T;
    }
    if (t == _im0nwja5.HomeCard) {
      return _im0nwja5.HomeCard.fromJson(data) as T;
    }
    if (t == _iyfj34j3.HomeFeedPage) {
      return _iyfj34j3.HomeFeedPage.fromJson(data) as T;
    }
    if (t == _iabb3f3a.JoinRequest) {
      return _iabb3f3a.JoinRequest.fromJson(data) as T;
    }
    if (t == _i5vd9zri.JoinRequestPage) {
      return _i5vd9zri.JoinRequestPage.fromJson(data) as T;
    }
    if (t == _ixf78lra.KeptProfile) {
      return _ixf78lra.KeptProfile.fromJson(data) as T;
    }
    if (t == _i65tc21s.MemberDayStatus) {
      return _i65tc21s.MemberDayStatus.fromJson(data) as T;
    }
    if (t == _iy6vp3i6.MemberPage) {
      return _iy6vp3i6.MemberPage.fromJson(data) as T;
    }
    if (t == _i4vydc8o.MessagePage) {
      return _i4vydc8o.MessagePage.fromJson(data) as T;
    }
    if (t == _i6ufruid.OpenVow) {
      return _i6ufruid.OpenVow.fromJson(data) as T;
    }
    if (t == _idd0e55h.RoomBoard) {
      return _idd0e55h.RoomBoard.fromJson(data) as T;
    }
    if (t == _iiejv3p6.VowCheckIn) {
      return _iiejv3p6.VowCheckIn.fromJson(data) as T;
    }
    if (t == _iz96iiq6.VowException) {
      return _iz96iiq6.VowException.fromJson(data) as T;
    }
    if (t == _iwq3va4n.VowInvite) {
      return _iwq3va4n.VowInvite.fromJson(data) as T;
    }
    if (t == _imwe36zt.VowMembership) {
      return _imwe36zt.VowMembership.fromJson(data) as T;
    }
    if (t == _ip5iwkae.VowMessage) {
      return _ip5iwkae.VowMessage.fromJson(data) as T;
    }
    if (t == _i4wblqhy.VowRoom) {
      return _i4wblqhy.VowRoom.fromJson(data) as T;
    }
    if (t == _ioquy3ul.VowRoomPage) {
      return _ioquy3ul.VowRoomPage.fromJson(data) as T;
    }
    if (t == _is.getType<_ifkvqf5h.EmailAlreadyRegisteredException?>()) {
      return (data != null
              ? _ifkvqf5h.EmailAlreadyRegisteredException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6auzokb.UsernameException?>()) {
      return (data != null ? _i6auzokb.UsernameException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibeas2fs.BlogPost?>()) {
      return (data != null ? _ibeas2fs.BlogPost.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5srmehb.FeedComment?>()) {
      return (data != null ? _i5srmehb.FeedComment.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2g4ey88.FeedCommentPage?>()) {
      return (data != null ? _i2g4ey88.FeedCommentPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3210eu2.FeedItem?>()) {
      return (data != null ? _i3210eu2.FeedItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itnngz98.FeedLike?>()) {
      return (data != null ? _itnngz98.FeedLike.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_im0nwja5.HomeCard?>()) {
      return (data != null ? _im0nwja5.HomeCard.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyfj34j3.HomeFeedPage?>()) {
      return (data != null ? _iyfj34j3.HomeFeedPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iabb3f3a.JoinRequest?>()) {
      return (data != null ? _iabb3f3a.JoinRequest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5vd9zri.JoinRequestPage?>()) {
      return (data != null ? _i5vd9zri.JoinRequestPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixf78lra.KeptProfile?>()) {
      return (data != null ? _ixf78lra.KeptProfile.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i65tc21s.MemberDayStatus?>()) {
      return (data != null ? _i65tc21s.MemberDayStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iy6vp3i6.MemberPage?>()) {
      return (data != null ? _iy6vp3i6.MemberPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4vydc8o.MessagePage?>()) {
      return (data != null ? _i4vydc8o.MessagePage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6ufruid.OpenVow?>()) {
      return (data != null ? _i6ufruid.OpenVow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idd0e55h.RoomBoard?>()) {
      return (data != null ? _idd0e55h.RoomBoard.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iiejv3p6.VowCheckIn?>()) {
      return (data != null ? _iiejv3p6.VowCheckIn.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iz96iiq6.VowException?>()) {
      return (data != null ? _iz96iiq6.VowException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwq3va4n.VowInvite?>()) {
      return (data != null ? _iwq3va4n.VowInvite.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imwe36zt.VowMembership?>()) {
      return (data != null ? _imwe36zt.VowMembership.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ip5iwkae.VowMessage?>()) {
      return (data != null ? _ip5iwkae.VowMessage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4wblqhy.VowRoom?>()) {
      return (data != null ? _i4wblqhy.VowRoom.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ioquy3ul.VowRoomPage?>()) {
      return (data != null ? _ioquy3ul.VowRoomPage.fromJson(data) : null) as T;
    }
    if (t == List<_i5srmehb.FeedComment>) {
      return (data as List)
              .map((e) => deserialize<_i5srmehb.FeedComment>(e))
              .toList()
          as T;
    }
    if (t == List<_im0nwja5.HomeCard>) {
      return (data as List)
              .map((e) => deserialize<_im0nwja5.HomeCard>(e))
              .toList()
          as T;
    }
    if (t == List<_iabb3f3a.JoinRequest>) {
      return (data as List)
              .map((e) => deserialize<_iabb3f3a.JoinRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i4wblqhy.VowRoom>) {
      return (data as List)
              .map((e) => deserialize<_i4wblqhy.VowRoom>(e))
              .toList()
          as T;
    }
    if (t == List<_i65tc21s.MemberDayStatus>) {
      return (data as List)
              .map((e) => deserialize<_i65tc21s.MemberDayStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_ip5iwkae.VowMessage>) {
      return (data as List)
              .map((e) => deserialize<_ip5iwkae.VowMessage>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iin21y76.FeedItem>) {
      return (data as List)
              .map((e) => deserialize<_iin21y76.FeedItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iw6g57rx.OpenVow>) {
      return (data as List)
              .map((e) => deserialize<_iw6g57rx.OpenVow>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ifkvqf5h.EmailAlreadyRegisteredException =>
        'EmailAlreadyRegisteredException',
      _i6auzokb.UsernameException => 'UsernameException',
      _izw8z7ou.Greeting => 'Greeting',
      _ibeas2fs.BlogPost => 'BlogPost',
      _i5srmehb.FeedComment => 'FeedComment',
      _i2g4ey88.FeedCommentPage => 'FeedCommentPage',
      _i3210eu2.FeedItem => 'FeedItem',
      _itnngz98.FeedLike => 'FeedLike',
      _im0nwja5.HomeCard => 'HomeCard',
      _iyfj34j3.HomeFeedPage => 'HomeFeedPage',
      _iabb3f3a.JoinRequest => 'JoinRequest',
      _i5vd9zri.JoinRequestPage => 'JoinRequestPage',
      _ixf78lra.KeptProfile => 'KeptProfile',
      _i65tc21s.MemberDayStatus => 'MemberDayStatus',
      _iy6vp3i6.MemberPage => 'MemberPage',
      _i4vydc8o.MessagePage => 'MessagePage',
      _i6ufruid.OpenVow => 'OpenVow',
      _idd0e55h.RoomBoard => 'RoomBoard',
      _iiejv3p6.VowCheckIn => 'VowCheckIn',
      _iz96iiq6.VowException => 'VowException',
      _iwq3va4n.VowInvite => 'VowInvite',
      _imwe36zt.VowMembership => 'VowMembership',
      _ip5iwkae.VowMessage => 'VowMessage',
      _i4wblqhy.VowRoom => 'VowRoom',
      _ioquy3ul.VowRoomPage => 'VowRoomPage',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('kept.', '');
    }

    switch (data) {
      case _ifkvqf5h.EmailAlreadyRegisteredException():
        return 'EmailAlreadyRegisteredException';
      case _i6auzokb.UsernameException():
        return 'UsernameException';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ibeas2fs.BlogPost():
        return 'BlogPost';
      case _i5srmehb.FeedComment():
        return 'FeedComment';
      case _i2g4ey88.FeedCommentPage():
        return 'FeedCommentPage';
      case _i3210eu2.FeedItem():
        return 'FeedItem';
      case _itnngz98.FeedLike():
        return 'FeedLike';
      case _im0nwja5.HomeCard():
        return 'HomeCard';
      case _iyfj34j3.HomeFeedPage():
        return 'HomeFeedPage';
      case _iabb3f3a.JoinRequest():
        return 'JoinRequest';
      case _i5vd9zri.JoinRequestPage():
        return 'JoinRequestPage';
      case _ixf78lra.KeptProfile():
        return 'KeptProfile';
      case _i65tc21s.MemberDayStatus():
        return 'MemberDayStatus';
      case _iy6vp3i6.MemberPage():
        return 'MemberPage';
      case _i4vydc8o.MessagePage():
        return 'MessagePage';
      case _i6ufruid.OpenVow():
        return 'OpenVow';
      case _idd0e55h.RoomBoard():
        return 'RoomBoard';
      case _iiejv3p6.VowCheckIn():
        return 'VowCheckIn';
      case _iz96iiq6.VowException():
        return 'VowException';
      case _iwq3va4n.VowInvite():
        return 'VowInvite';
      case _imwe36zt.VowMembership():
        return 'VowMembership';
      case _ip5iwkae.VowMessage():
        return 'VowMessage';
      case _i4wblqhy.VowRoom():
        return 'VowRoom';
      case _ioquy3ul.VowRoomPage():
        return 'VowRoomPage';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'EmailAlreadyRegisteredException') {
      return deserialize<_ifkvqf5h.EmailAlreadyRegisteredException>(
        data['data'],
      );
    }
    if (dataClassName == 'UsernameException') {
      return deserialize<_i6auzokb.UsernameException>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'BlogPost') {
      return deserialize<_ibeas2fs.BlogPost>(data['data']);
    }
    if (dataClassName == 'FeedComment') {
      return deserialize<_i5srmehb.FeedComment>(data['data']);
    }
    if (dataClassName == 'FeedCommentPage') {
      return deserialize<_i2g4ey88.FeedCommentPage>(data['data']);
    }
    if (dataClassName == 'FeedItem') {
      return deserialize<_i3210eu2.FeedItem>(data['data']);
    }
    if (dataClassName == 'FeedLike') {
      return deserialize<_itnngz98.FeedLike>(data['data']);
    }
    if (dataClassName == 'HomeCard') {
      return deserialize<_im0nwja5.HomeCard>(data['data']);
    }
    if (dataClassName == 'HomeFeedPage') {
      return deserialize<_iyfj34j3.HomeFeedPage>(data['data']);
    }
    if (dataClassName == 'JoinRequest') {
      return deserialize<_iabb3f3a.JoinRequest>(data['data']);
    }
    if (dataClassName == 'JoinRequestPage') {
      return deserialize<_i5vd9zri.JoinRequestPage>(data['data']);
    }
    if (dataClassName == 'KeptProfile') {
      return deserialize<_ixf78lra.KeptProfile>(data['data']);
    }
    if (dataClassName == 'MemberDayStatus') {
      return deserialize<_i65tc21s.MemberDayStatus>(data['data']);
    }
    if (dataClassName == 'MemberPage') {
      return deserialize<_iy6vp3i6.MemberPage>(data['data']);
    }
    if (dataClassName == 'MessagePage') {
      return deserialize<_i4vydc8o.MessagePage>(data['data']);
    }
    if (dataClassName == 'OpenVow') {
      return deserialize<_i6ufruid.OpenVow>(data['data']);
    }
    if (dataClassName == 'RoomBoard') {
      return deserialize<_idd0e55h.RoomBoard>(data['data']);
    }
    if (dataClassName == 'VowCheckIn') {
      return deserialize<_iiejv3p6.VowCheckIn>(data['data']);
    }
    if (dataClassName == 'VowException') {
      return deserialize<_iz96iiq6.VowException>(data['data']);
    }
    if (dataClassName == 'VowInvite') {
      return deserialize<_iwq3va4n.VowInvite>(data['data']);
    }
    if (dataClassName == 'VowMembership') {
      return deserialize<_imwe36zt.VowMembership>(data['data']);
    }
    if (dataClassName == 'VowMessage') {
      return deserialize<_ip5iwkae.VowMessage>(data['data']);
    }
    if (dataClassName == 'VowRoom') {
      return deserialize<_i4wblqhy.VowRoom>(data['data']);
    }
    if (dataClassName == 'VowRoomPage') {
      return deserialize<_ioquy3ul.VowRoomPage>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('kept', this);
    _iacs.Protocol().registerHostProtocol('kept', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ibeas2fs.BlogPost:
        return _ibeas2fs.BlogPost.t;
      case _i5srmehb.FeedComment:
        return _i5srmehb.FeedComment.t;
      case _itnngz98.FeedLike:
        return _itnngz98.FeedLike.t;
      case _iabb3f3a.JoinRequest:
        return _iabb3f3a.JoinRequest.t;
      case _iiejv3p6.VowCheckIn:
        return _iiejv3p6.VowCheckIn.t;
      case _iwq3va4n.VowInvite:
        return _iwq3va4n.VowInvite.t;
      case _imwe36zt.VowMembership:
        return _imwe36zt.VowMembership.t;
      case _ip5iwkae.VowMessage:
        return _ip5iwkae.VowMessage.t;
      case _i4wblqhy.VowRoom:
        return _i4wblqhy.VowRoom.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'kept';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
