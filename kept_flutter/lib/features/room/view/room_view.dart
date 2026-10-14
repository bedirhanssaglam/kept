import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/utility/activity_line.dart';
import '../../../product/utility/constants/kept_day.dart';
import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/components/kept_widgets.dart';
import '../../../product/service/vow_repository.dart';
import '../../../features/vows/domain/vow_codes.dart';
import '../../../features/vows/domain/vow_labels.dart';
import '../../auth/view/sign_in_sheet.dart';
import 'members_view.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

part 'room_view_mixin.dart';
part 'widgets/today_tab.dart';
part 'widgets/chat_tab.dart';
part 'widgets/room_scaffold.dart';
part 'widgets/check_in_sheet.dart';
part 'widgets/invite_code_dialog.dart';
part 'widgets/join_requests_sheet.dart';

class RoomView extends ConsumerStatefulWidget {
  const RoomView({super.key, required this.roomId});

  final int roomId;

  @override
  ConsumerState<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends ConsumerState<RoomView>
    with SingleTickerProviderStateMixin, _RoomViewMixin {
  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _tabs.addListener(() {
      if (!_tabs.indexIsChanging && mounted) setState(() {});
    });
    _listenBoard();
  }

  @override
  void dispose() {
    _tabs.dispose();
    _chatController.dispose();
    _chatScroll.dispose();
    _boardSub?.cancel();
    _chatSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RoomScaffold(
      board: _board,
      error: _error,
      messages: _messages,
      tabs: _tabs,
      busy: _busy,
      sending: _sending,
      chatScroll: _chatScroll,
      chatController: _chatController,
      myUserId: _myUserId,
      canSeeChat: _canSeeChat,
      onKept: () => _checkIn(true),
      onBroke: () => _checkIn(false),
      onJoin: _offerJoin,
      onSend: _sendChat,
      onSeeMembers: _openMembers,
      onCreateInvite: _createInvite,
      onReviewRequests: _openJoinRequests,
    );
  }

  String get _myUserId {
    if (!client.auth.isAuthenticated) return '';
    return client.auth.authInfoListenable.value?.authUserId.uuid ?? '';
  }

  void _openMembers() {
    final board = _board;
    if (board == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MembersView(
          roomId: widget.roomId,
          title: board.room.title,
        ),
      ),
    );
  }
}
