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
import 'package:kept_server/src/generated/vows/feed/feed_item.dart'
    as _iv80qq9i;
import 'package:kept_server/src/generated/vows/room/open_vow.dart' as _i0731mcn;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'auth/email_already_registered_exception.dart' as _ifkvqf5h;
import 'auth/username_exception.dart' as _i6auzokb;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'vows/chat/message_page.dart' as _i7elbagc;
import 'vows/chat/vow_message.dart' as _i1w29guz;
import 'vows/check_in/vow_check_in.dart' as _iniohzds;
import 'vows/feed/blog_post.dart' as _ierdsgli;
import 'vows/feed/feed_comment.dart' as _iqrrdsa2;
import 'vows/feed/feed_comment_page.dart' as _i3tiu6aa;
import 'vows/feed/feed_item.dart' as _i3sk9684;
import 'vows/feed/feed_like.dart' as _irknecxh;
import 'vows/feed/home_card.dart' as _ijxtms38;
import 'vows/feed/home_feed_page.dart' as _ig5j3ok4;
import 'vows/profile/kept_profile.dart' as _ily5j06k;
import 'vows/room/join_request.dart' as _ij8wkdse;
import 'vows/room/join_request_page.dart' as _i7ftyo6r;
import 'vows/room/member_day_status.dart' as _idpvt9xu;
import 'vows/room/member_page.dart' as _ixj1qrzj;
import 'vows/room/open_vow.dart' as _i8tz11yp;
import 'vows/room/room_board.dart' as _iq7dfraf;
import 'vows/room/vow_invite.dart' as _i5jag40z;
import 'vows/room/vow_membership.dart' as _idfq387w;
import 'vows/room/vow_room.dart' as _ic2c10je;
import 'vows/room/vow_room_page.dart' as _ivdncx6h;
import 'vows/vow_exception.dart' as _iz96iiq6;
export 'auth/email_already_registered_exception.dart';
export 'auth/username_exception.dart';
export 'greetings/greeting.dart';
export 'vows/chat/message_page.dart';
export 'vows/chat/vow_message.dart';
export 'vows/check_in/vow_check_in.dart';
export 'vows/feed/blog_post.dart';
export 'vows/feed/feed_comment.dart';
export 'vows/feed/feed_comment_page.dart';
export 'vows/feed/feed_item.dart';
export 'vows/feed/feed_like.dart';
export 'vows/feed/home_card.dart';
export 'vows/feed/home_feed_page.dart';
export 'vows/profile/kept_profile.dart';
export 'vows/room/join_request.dart';
export 'vows/room/join_request_page.dart';
export 'vows/room/member_day_status.dart';
export 'vows/room/member_page.dart';
export 'vows/room/open_vow.dart';
export 'vows/room/room_board.dart';
export 'vows/room/vow_invite.dart';
export 'vows/room/vow_membership.dart';
export 'vows/room/vow_room.dart';
export 'vows/room/vow_room_page.dart';
export 'vows/vow_exception.dart';

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
        _isp.ColumnDefinition(
          name: 'durationDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'startsOn',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'\'',
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
    if (t == _i7elbagc.MessagePage) {
      return _i7elbagc.MessagePage.fromJson(data) as T;
    }
    if (t == _i1w29guz.VowMessage) {
      return _i1w29guz.VowMessage.fromJson(data) as T;
    }
    if (t == _iniohzds.VowCheckIn) {
      return _iniohzds.VowCheckIn.fromJson(data) as T;
    }
    if (t == _ierdsgli.BlogPost) {
      return _ierdsgli.BlogPost.fromJson(data) as T;
    }
    if (t == _iqrrdsa2.FeedComment) {
      return _iqrrdsa2.FeedComment.fromJson(data) as T;
    }
    if (t == _i3tiu6aa.FeedCommentPage) {
      return _i3tiu6aa.FeedCommentPage.fromJson(data) as T;
    }
    if (t == _i3sk9684.FeedItem) {
      return _i3sk9684.FeedItem.fromJson(data) as T;
    }
    if (t == _irknecxh.FeedLike) {
      return _irknecxh.FeedLike.fromJson(data) as T;
    }
    if (t == _ijxtms38.HomeCard) {
      return _ijxtms38.HomeCard.fromJson(data) as T;
    }
    if (t == _ig5j3ok4.HomeFeedPage) {
      return _ig5j3ok4.HomeFeedPage.fromJson(data) as T;
    }
    if (t == _ily5j06k.KeptProfile) {
      return _ily5j06k.KeptProfile.fromJson(data) as T;
    }
    if (t == _ij8wkdse.JoinRequest) {
      return _ij8wkdse.JoinRequest.fromJson(data) as T;
    }
    if (t == _i7ftyo6r.JoinRequestPage) {
      return _i7ftyo6r.JoinRequestPage.fromJson(data) as T;
    }
    if (t == _idpvt9xu.MemberDayStatus) {
      return _idpvt9xu.MemberDayStatus.fromJson(data) as T;
    }
    if (t == _ixj1qrzj.MemberPage) {
      return _ixj1qrzj.MemberPage.fromJson(data) as T;
    }
    if (t == _i8tz11yp.OpenVow) {
      return _i8tz11yp.OpenVow.fromJson(data) as T;
    }
    if (t == _iq7dfraf.RoomBoard) {
      return _iq7dfraf.RoomBoard.fromJson(data) as T;
    }
    if (t == _i5jag40z.VowInvite) {
      return _i5jag40z.VowInvite.fromJson(data) as T;
    }
    if (t == _idfq387w.VowMembership) {
      return _idfq387w.VowMembership.fromJson(data) as T;
    }
    if (t == _ic2c10je.VowRoom) {
      return _ic2c10je.VowRoom.fromJson(data) as T;
    }
    if (t == _ivdncx6h.VowRoomPage) {
      return _ivdncx6h.VowRoomPage.fromJson(data) as T;
    }
    if (t == _iz96iiq6.VowException) {
      return _iz96iiq6.VowException.fromJson(data) as T;
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
    if (t == _is.getType<_i7elbagc.MessagePage?>()) {
      return (data != null ? _i7elbagc.MessagePage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1w29guz.VowMessage?>()) {
      return (data != null ? _i1w29guz.VowMessage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iniohzds.VowCheckIn?>()) {
      return (data != null ? _iniohzds.VowCheckIn.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ierdsgli.BlogPost?>()) {
      return (data != null ? _ierdsgli.BlogPost.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqrrdsa2.FeedComment?>()) {
      return (data != null ? _iqrrdsa2.FeedComment.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3tiu6aa.FeedCommentPage?>()) {
      return (data != null ? _i3tiu6aa.FeedCommentPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3sk9684.FeedItem?>()) {
      return (data != null ? _i3sk9684.FeedItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irknecxh.FeedLike?>()) {
      return (data != null ? _irknecxh.FeedLike.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijxtms38.HomeCard?>()) {
      return (data != null ? _ijxtms38.HomeCard.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ig5j3ok4.HomeFeedPage?>()) {
      return (data != null ? _ig5j3ok4.HomeFeedPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ily5j06k.KeptProfile?>()) {
      return (data != null ? _ily5j06k.KeptProfile.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ij8wkdse.JoinRequest?>()) {
      return (data != null ? _ij8wkdse.JoinRequest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7ftyo6r.JoinRequestPage?>()) {
      return (data != null ? _i7ftyo6r.JoinRequestPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idpvt9xu.MemberDayStatus?>()) {
      return (data != null ? _idpvt9xu.MemberDayStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixj1qrzj.MemberPage?>()) {
      return (data != null ? _ixj1qrzj.MemberPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8tz11yp.OpenVow?>()) {
      return (data != null ? _i8tz11yp.OpenVow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iq7dfraf.RoomBoard?>()) {
      return (data != null ? _iq7dfraf.RoomBoard.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5jag40z.VowInvite?>()) {
      return (data != null ? _i5jag40z.VowInvite.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idfq387w.VowMembership?>()) {
      return (data != null ? _idfq387w.VowMembership.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ic2c10je.VowRoom?>()) {
      return (data != null ? _ic2c10je.VowRoom.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ivdncx6h.VowRoomPage?>()) {
      return (data != null ? _ivdncx6h.VowRoomPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iz96iiq6.VowException?>()) {
      return (data != null ? _iz96iiq6.VowException.fromJson(data) : null) as T;
    }
    if (t == List<_i1w29guz.VowMessage>) {
      return (data as List)
              .map((e) => deserialize<_i1w29guz.VowMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_iqrrdsa2.FeedComment>) {
      return (data as List)
              .map((e) => deserialize<_iqrrdsa2.FeedComment>(e))
              .toList()
          as T;
    }
    if (t == List<_ijxtms38.HomeCard>) {
      return (data as List)
              .map((e) => deserialize<_ijxtms38.HomeCard>(e))
              .toList()
          as T;
    }
    if (t == List<_ic2c10je.VowRoom>) {
      return (data as List)
              .map((e) => deserialize<_ic2c10je.VowRoom>(e))
              .toList()
          as T;
    }
    if (t == List<_ij8wkdse.JoinRequest>) {
      return (data as List)
              .map((e) => deserialize<_ij8wkdse.JoinRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_idpvt9xu.MemberDayStatus>) {
      return (data as List)
              .map((e) => deserialize<_idpvt9xu.MemberDayStatus>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iv80qq9i.FeedItem>) {
      return (data as List)
              .map((e) => deserialize<_iv80qq9i.FeedItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i0731mcn.OpenVow>) {
      return (data as List)
              .map((e) => deserialize<_i0731mcn.OpenVow>(e))
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
      _i7elbagc.MessagePage => 'MessagePage',
      _i1w29guz.VowMessage => 'VowMessage',
      _iniohzds.VowCheckIn => 'VowCheckIn',
      _ierdsgli.BlogPost => 'BlogPost',
      _iqrrdsa2.FeedComment => 'FeedComment',
      _i3tiu6aa.FeedCommentPage => 'FeedCommentPage',
      _i3sk9684.FeedItem => 'FeedItem',
      _irknecxh.FeedLike => 'FeedLike',
      _ijxtms38.HomeCard => 'HomeCard',
      _ig5j3ok4.HomeFeedPage => 'HomeFeedPage',
      _ily5j06k.KeptProfile => 'KeptProfile',
      _ij8wkdse.JoinRequest => 'JoinRequest',
      _i7ftyo6r.JoinRequestPage => 'JoinRequestPage',
      _idpvt9xu.MemberDayStatus => 'MemberDayStatus',
      _ixj1qrzj.MemberPage => 'MemberPage',
      _i8tz11yp.OpenVow => 'OpenVow',
      _iq7dfraf.RoomBoard => 'RoomBoard',
      _i5jag40z.VowInvite => 'VowInvite',
      _idfq387w.VowMembership => 'VowMembership',
      _ic2c10je.VowRoom => 'VowRoom',
      _ivdncx6h.VowRoomPage => 'VowRoomPage',
      _iz96iiq6.VowException => 'VowException',
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
      case _i7elbagc.MessagePage():
        return 'MessagePage';
      case _i1w29guz.VowMessage():
        return 'VowMessage';
      case _iniohzds.VowCheckIn():
        return 'VowCheckIn';
      case _ierdsgli.BlogPost():
        return 'BlogPost';
      case _iqrrdsa2.FeedComment():
        return 'FeedComment';
      case _i3tiu6aa.FeedCommentPage():
        return 'FeedCommentPage';
      case _i3sk9684.FeedItem():
        return 'FeedItem';
      case _irknecxh.FeedLike():
        return 'FeedLike';
      case _ijxtms38.HomeCard():
        return 'HomeCard';
      case _ig5j3ok4.HomeFeedPage():
        return 'HomeFeedPage';
      case _ily5j06k.KeptProfile():
        return 'KeptProfile';
      case _ij8wkdse.JoinRequest():
        return 'JoinRequest';
      case _i7ftyo6r.JoinRequestPage():
        return 'JoinRequestPage';
      case _idpvt9xu.MemberDayStatus():
        return 'MemberDayStatus';
      case _ixj1qrzj.MemberPage():
        return 'MemberPage';
      case _i8tz11yp.OpenVow():
        return 'OpenVow';
      case _iq7dfraf.RoomBoard():
        return 'RoomBoard';
      case _i5jag40z.VowInvite():
        return 'VowInvite';
      case _idfq387w.VowMembership():
        return 'VowMembership';
      case _ic2c10je.VowRoom():
        return 'VowRoom';
      case _ivdncx6h.VowRoomPage():
        return 'VowRoomPage';
      case _iz96iiq6.VowException():
        return 'VowException';
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
    if (dataClassName == 'MessagePage') {
      return deserialize<_i7elbagc.MessagePage>(data['data']);
    }
    if (dataClassName == 'VowMessage') {
      return deserialize<_i1w29guz.VowMessage>(data['data']);
    }
    if (dataClassName == 'VowCheckIn') {
      return deserialize<_iniohzds.VowCheckIn>(data['data']);
    }
    if (dataClassName == 'BlogPost') {
      return deserialize<_ierdsgli.BlogPost>(data['data']);
    }
    if (dataClassName == 'FeedComment') {
      return deserialize<_iqrrdsa2.FeedComment>(data['data']);
    }
    if (dataClassName == 'FeedCommentPage') {
      return deserialize<_i3tiu6aa.FeedCommentPage>(data['data']);
    }
    if (dataClassName == 'FeedItem') {
      return deserialize<_i3sk9684.FeedItem>(data['data']);
    }
    if (dataClassName == 'FeedLike') {
      return deserialize<_irknecxh.FeedLike>(data['data']);
    }
    if (dataClassName == 'HomeCard') {
      return deserialize<_ijxtms38.HomeCard>(data['data']);
    }
    if (dataClassName == 'HomeFeedPage') {
      return deserialize<_ig5j3ok4.HomeFeedPage>(data['data']);
    }
    if (dataClassName == 'KeptProfile') {
      return deserialize<_ily5j06k.KeptProfile>(data['data']);
    }
    if (dataClassName == 'JoinRequest') {
      return deserialize<_ij8wkdse.JoinRequest>(data['data']);
    }
    if (dataClassName == 'JoinRequestPage') {
      return deserialize<_i7ftyo6r.JoinRequestPage>(data['data']);
    }
    if (dataClassName == 'MemberDayStatus') {
      return deserialize<_idpvt9xu.MemberDayStatus>(data['data']);
    }
    if (dataClassName == 'MemberPage') {
      return deserialize<_ixj1qrzj.MemberPage>(data['data']);
    }
    if (dataClassName == 'OpenVow') {
      return deserialize<_i8tz11yp.OpenVow>(data['data']);
    }
    if (dataClassName == 'RoomBoard') {
      return deserialize<_iq7dfraf.RoomBoard>(data['data']);
    }
    if (dataClassName == 'VowInvite') {
      return deserialize<_i5jag40z.VowInvite>(data['data']);
    }
    if (dataClassName == 'VowMembership') {
      return deserialize<_idfq387w.VowMembership>(data['data']);
    }
    if (dataClassName == 'VowRoom') {
      return deserialize<_ic2c10je.VowRoom>(data['data']);
    }
    if (dataClassName == 'VowRoomPage') {
      return deserialize<_ivdncx6h.VowRoomPage>(data['data']);
    }
    if (dataClassName == 'VowException') {
      return deserialize<_iz96iiq6.VowException>(data['data']);
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
      case _i1w29guz.VowMessage:
        return _i1w29guz.VowMessage.t;
      case _iniohzds.VowCheckIn:
        return _iniohzds.VowCheckIn.t;
      case _ierdsgli.BlogPost:
        return _ierdsgli.BlogPost.t;
      case _iqrrdsa2.FeedComment:
        return _iqrrdsa2.FeedComment.t;
      case _irknecxh.FeedLike:
        return _irknecxh.FeedLike.t;
      case _ij8wkdse.JoinRequest:
        return _ij8wkdse.JoinRequest.t;
      case _i5jag40z.VowInvite:
        return _i5jag40z.VowInvite.t;
      case _idfq387w.VowMembership:
        return _idfq387w.VowMembership.t;
      case _ic2c10je.VowRoom:
        return _ic2c10je.VowRoom.t;
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
