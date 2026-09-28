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
import '../../../product/init/dependency/dependency_items.dart';
import '../../../product/service/vow_repository.dart';
import '../../../features/vows/domain/vow_codes.dart';
import '../../../features/vows/domain/vow_labels.dart';
import '../../../product/init/language/localization.dart';
import '../../auth/view/sign_in_sheet.dart';
import 'members_view.dart';

part 'widgets/today_tab.dart';
part 'widgets/chat_tab.dart';

class RoomView extends ConsumerStatefulWidget {
  const RoomView({super.key, required this.roomId});

  final int roomId;

  @override
  ConsumerState<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends ConsumerState<RoomView>
    with SingleTickerProviderStateMixin {
  VowRepository get _repo => ref.read(vowRepositoryProvider);
  final _chatController = TextEditingController();
  final _chatScroll = ScrollController();

  late final TabController _tabs;
  StreamSubscription<RoomBoard>? _boardSub;
  StreamSubscription<VowMessage>? _chatSub;

  RoomBoard? _board;
  final List<VowMessage> _messages = [];
  String? _error;
  bool _busy = false;
  bool _sending = false;
  bool _chatHistoryReady = false;
  int _chatListenGen = 0;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _tabs.addListener(() {
      if (!_tabs.indexIsChanging && mounted) setState(() {});
    });
    _listenBoard();
  }

  bool _canSeeChat(RoomBoard? board) {
    if (board == null) return false;
    return board.isMember || board.room.joinPolicy == 'open';
  }

  Future<void> _listenBoard() async {
    await _boardSub?.cancel();
    try {
      _boardSub = _repo
          .watchBoard(widget.roomId)
          .listen(
            (board) {
              if (!mounted) return;
              final wasAllowed = _canSeeChat(_board);
              setState(() => _board = board);
              final nowAllowed = _canSeeChat(board);
              if (nowAllowed && !wasAllowed) {
                _listenChat();
              } else if (!nowAllowed && wasAllowed) {
                _chatSub?.cancel();
                _chatSub = null;
                setState(() {
                  _messages.clear();
                  _chatHistoryReady = false;
                });
              } else if (nowAllowed && _chatSub == null) {
                _listenChat();
              }
            },
            onError: (Object e) {
              if (!mounted) return;
              setState(() => _error = '$e');
              Future<void>.delayed(const Duration(seconds: 1), () {
                if (mounted) _listenBoard();
              });
            },
            onDone: () {
              if (!mounted) return;
              Future<void>.delayed(const Duration(milliseconds: 400), () {
                if (mounted) _listenBoard();
              });
            },
          );
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    }
  }

  void _appendMessage(VowMessage message) {
    if (_messages.any((m) => m.id != null && m.id == message.id)) return;
    setState(() => _messages.add(message));
    _jumpChatToEnd();
  }

  Future<void> _listenChat() async {
    final gen = ++_chatListenGen;
    await _chatSub?.cancel();
    _chatHistoryReady = false;
    final pending = <VowMessage>[];

    try {
      // Subscribe first so messages posted during history fetch are not lost.
      _chatSub = _repo
          .watchChat(widget.roomId)
          .listen(
            (message) {
              if (!mounted || gen != _chatListenGen) return;
              if (!_chatHistoryReady) {
                pending.add(message);
                return;
              }
              _appendMessage(message);
            },
            onError: (Object e) {
              if (!mounted || gen != _chatListenGen) return;
              setState(() => _error = '$e');
              Future<void>.delayed(const Duration(seconds: 1), () {
                if (mounted && gen == _chatListenGen) _listenChat();
              });
            },
            onDone: () {
              if (!mounted || gen != _chatListenGen) return;
              Future<void>.delayed(const Duration(milliseconds: 400), () {
                if (mounted && gen == _chatListenGen) _listenChat();
              });
            },
          );

      final history = await _repo.listMessages(
        widget.roomId,
        limit: 60,
        offset: 0,
      );
      if (!mounted || gen != _chatListenGen) return;
      setState(() {
        _messages
          ..clear()
          ..addAll(history.items);
        for (final message in pending) {
          if (!_messages.any((m) => m.id != null && m.id == message.id)) {
            _messages.add(message);
          }
        }
        _chatHistoryReady = true;
      });
      _jumpChatToEnd();
    } catch (e) {
      if (mounted && gen == _chatListenGen) {
        setState(() => _error = '$e');
      }
    }
  }

  void _jumpChatToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_chatScroll.hasClients) return;
      _chatScroll.animateTo(
        _chatScroll.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<bool> _ensureMember() async {
    if (!client.auth.isAuthenticated) {
      final ok = await showSignInSheet(context);
      if (!ok) return false;
    }
    if (_board?.isMember == true) return true;
    return _offerJoin();
  }

  Future<bool> _offerJoin({String? inviteCode}) async {
    final board = _board;
    if (board == null) return false;
    final policy = board.room.joinPolicy;

    if (policy == 'closed') {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.vowClosed),
            backgroundColor: KeptTheme.broke,
          ),
        );
      }
      return false;
    }

    if (policy == 'approval') {
      if (board.myRequestStatus == 'pending') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.requestPending),
            ),
          );
        }
        return false;
      }
      try {
        await _repo.requestJoin(widget.roomId);
        final refreshed = await _repo.getBoard(widget.roomId);
        if (mounted) setState(() => _board = refreshed);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.requestSent),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
          );
        }
      }
      return false;
    }

    if (policy == 'invite') {
      final code = (inviteCode ?? await _askInviteCode())?.trim();
      if (code == null || code.isEmpty) return false;
      try {
        final next = await _repo.joinWithInvite(code: code);
        if (mounted) setState(() => _board = next);
        if (next.isMember) _listenChat();
        return next.isMember;
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
          );
        }
        return false;
      }
    }

    // open
    try {
      final next = await _repo.joinRoom(widget.roomId);
      if (mounted) setState(() => _board = next);
      if (next.isMember) _listenChat();
      return next.isMember;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
        );
      }
      return false;
    }
  }

  Future<String?> _askInviteCode() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.kept.panel,
          title: Text(
            context.l10n.inviteCode,
            style: GoogleFonts.sora(color: context.kept.paper),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            style: TextStyle(color: context.kept.paper),
            decoration: InputDecoration(
              hintText: context.l10n.inviteHint,
              hintStyle: TextStyle(color: context.kept.mist),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: Text(context.l10n.join),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openJoinRequests() async {
    try {
      final page = await _repo.listJoinRequests(
        widget.roomId,
        limit: 30,
        offset: 0,
      );
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        backgroundColor: context.kept.panel,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.joinRequests,
                    style: GoogleFonts.sora(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: context.kept.paper,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (page.items.isEmpty)
                    Text(
                      context.l10n.noPendingRequests,
                      style: GoogleFonts.manrope(color: context.kept.mist),
                    )
                  else
                    ...page.items.map(
                      (req) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          req.displayName,
                          style: GoogleFonts.manrope(
                            color: context.kept.paper,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          context.l10n.wantsToJoin,
                          style: GoogleFonts.manrope(color: context.kept.mist),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await _repo.reviewJoinRequest(
                                  requestId: req.id!,
                                  approve: false,
                                );
                                if (context.mounted) Navigator.pop(context);
                                final board = await _repo.getBoard(
                                  widget.roomId,
                                );
                                if (mounted) setState(() => _board = board);
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                color: KeptTheme.broke,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final board = await _repo.reviewJoinRequest(
                                  requestId: req.id!,
                                  approve: true,
                                );
                                if (context.mounted) Navigator.pop(context);
                                if (mounted) setState(() => _board = board);
                              },
                              icon: Icon(
                                Icons.check_rounded,
                                color: KeptTheme.kept,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
      );
    }
  }

  Future<void> _checkIn(bool kept) async {
    setState(() => _busy = true);
    try {
      final ok = await _ensureMember();
      if (!ok) return;

      final draft = await _askCheckInDetails(kept);
      if (draft == null) return;

      final board = await _repo.checkIn(
        roomId: widget.roomId,
        kept: kept,
        note: draft.note,
        shareToFeed: draft.shareToFeed,
      );
      if (mounted) {
        setState(() => _board = board);
        _tabs.animateTo(1);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<({String? note, bool shareToFeed})?> _askCheckInDetails(
    bool kept,
  ) async {
    final controller = TextEditingController();
    var shareToFeed = false;
    return showModalBottomSheet<({String? note, bool shareToFeed})>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.kept.panel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                20 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    kept
                        ? context.l10n.noteKeptPrompt
                        : context.l10n.noteBrokePrompt,
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: context.kept.paper,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.noteBody,
                    style: GoogleFonts.manrope(
                      color: context.kept.mist,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    style: TextStyle(color: context.kept.paper),
                    decoration: InputDecoration(
                      hintText: kept
                          ? context.l10n.noteKeptHint
                          : context.l10n.noteBrokeHint,
                      hintStyle: TextStyle(color: context.kept.mist),
                      filled: true,
                      fillColor: context.kept.ink,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: context.kept.line),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  KeptNativeSwitchTile(
                    value: shareToFeed,
                    title: context.l10n.shareToFeed,
                    subtitle: context.l10n.shareToFeedHelp,
                    onChanged: (v) => setModalState(() => shareToFeed = v),
                  ),
                  const SizedBox(height: 8),
                  KeptPrimaryButton(
                    label: kept
                        ? context.l10n.postKept
                        : context.l10n.postBroke,
                    onPressed: () => Navigator.pop(context, (
                      note: controller.text.trim(),
                      shareToFeed: shareToFeed,
                    )),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.l10n.cancel),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _sendChat() async {
    final text = _chatController.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    try {
      final ok = await _ensureMember();
      if (!ok) return;
      final sent = await _repo.sendMessage(roomId: widget.roomId, body: text);
      if (!mounted) return;
      // Don't wait on the live stream — show the saved message immediately.
      _appendMessage(sent);
      _chatController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
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
    final board = _board;
    final room = board?.room;

    return Scaffold(
      backgroundColor: context.kept.void_,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.kept.wash, context.kept.void_],
          ),
        ),
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: KeptBreakpoints.contentMax,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_rounded),
                          color: context.kept.paper,
                        ),
                        Expanded(
                          child: Text(
                            room?.title ?? context.l10n.vowRoom,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: context.kept.paper,
                            ),
                          ),
                        ),
                        if (board != null)
                          Text(
                            context.l10n.inRoom(board.room.memberCount),
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _error!,
                        style: TextStyle(color: KeptTheme.broke),
                      ),
                    ),
                  if (board == null)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: KeptTheme.accent,
                        ),
                      ),
                    )
                  else ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                      child: keptUsesNativeCupertino
                          ? SizedBox(
                              height: 36,
                              width: double.infinity,
                              child: CNSegmentedControl(
                                labels: [
                                  context.l10n.tabToday,
                                  !_canSeeChat(board)
                                      ? context.l10n.tabChat
                                      : _messages.isEmpty
                                      ? context.l10n.tabChat
                                      : context.l10n.tabChatCount(
                                          _messages.length,
                                        ),
                                ],
                                selectedIndex: _tabs.index,
                                onValueChanged: (i) {
                                  if (i == _tabs.index) return;
                                  _tabs.animateTo(i);
                                },
                                color: KeptTheme.accent,
                                height: 36,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: context.kept.panel.withValues(
                                  alpha: 0.85,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: context.kept.line),
                              ),
                              child: TabBar(
                                controller: _tabs,
                                indicator: BoxDecoration(
                                  color: KeptTheme.accent.withValues(
                                    alpha: 0.18,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: KeptTheme.accent,
                                unselectedLabelColor: context.kept.mist,
                                labelStyle: GoogleFonts.sora(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                                tabs: [
                                  Tab(text: context.l10n.tabToday),
                                  Tab(
                                    text: !_canSeeChat(board)
                                        ? context.l10n.tabChat
                                        : _messages.isEmpty
                                        ? context.l10n.tabChat
                                        : context.l10n.tabChatCount(
                                            _messages.length,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabs,
                        children: [
                          _TodayTab(
                            board: board,
                            busy: _busy,
                            myUserId: client.auth.isAuthenticated
                                ? (client
                                          .auth
                                          .authInfoListenable
                                          .value
                                          ?.authUserId
                                          .uuid ??
                                      '')
                                : '',
                            onKept: () => _checkIn(true),
                            onBroke: () => _checkIn(false),
                            onJoin: _offerJoin,
                            onSeeMembers: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MembersView(
                                    roomId: widget.roomId,
                                    title: board.room.title,
                                  ),
                                ),
                              );
                            },
                            onCreateInvite: board.isAdmin
                                ? () async {
                                    try {
                                      final code = await _repo.createInviteCode(
                                        widget.roomId,
                                      );
                                      if (!mounted) return;
                                      await showDialog<void>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: context.kept.panel,
                                          title: Text(
                                            context.l10n.inviteCode,
                                            style: GoogleFonts.sora(
                                              color: context.kept.paper,
                                            ),
                                          ),
                                          content: SelectableText(
                                            code,
                                            style: GoogleFonts.sora(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700,
                                              color: KeptTheme.accent,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(context.l10n.done),
                                            ),
                                          ],
                                        ),
                                      );
                                    } catch (e) {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('$e'),
                                          backgroundColor: KeptTheme.broke,
                                        ),
                                      );
                                    }
                                  }
                                : null,
                            onReviewRequests: board.isAdmin
                                ? () => _openJoinRequests()
                                : null,
                          ),
                          _ChatTab(
                            locked: !_canSeeChat(board),
                            joinPolicy: board.room.joinPolicy,
                            messages: _messages,
                            scrollController: _chatScroll,
                            textController: _chatController,
                            sending: _sending,
                            onSend: _sendChat,
                            onJoin: () {
                              if (board.room.joinPolicy == 'invite') {
                                _tabs.animateTo(0);
                              } else {
                                _offerJoin();
                              }
                            },
                            myUserId: client.auth.isAuthenticated
                                ? (client
                                          .auth
                                          .authInfoListenable
                                          .value
                                          ?.authUserId
                                          .uuid ??
                                      '')
                                : '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
