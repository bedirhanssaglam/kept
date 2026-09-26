import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../core/layout/kept_breakpoints.dart';
import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_native.dart';
import '../../../core/widgets/kept_widgets.dart';
import '../../../data/vow_repository.dart';
import '../../auth/presentation/sign_in_sheet.dart';
import 'members_screen.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key, required this.roomId});

  final int roomId;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    with SingleTickerProviderStateMixin {
  final _repo = VowRepository();
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
          const SnackBar(
            content: Text('This vow is closed to new members.'),
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
            const SnackBar(
              content: Text('Join request already pending admin approval.'),
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
            const SnackBar(
              content: Text('Request sent. An admin will review it.'),
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
          backgroundColor: KeptTheme.panel,
          title: Text(
            'Invite code',
            style: GoogleFonts.sora(color: KeptTheme.paper),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(color: KeptTheme.paper),
            decoration: const InputDecoration(
              hintText: 'e.g. AB12CD34',
              hintStyle: TextStyle(color: KeptTheme.mist),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('Join'),
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
        backgroundColor: KeptTheme.panel,
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
                    'Join requests',
                    style: GoogleFonts.sora(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: KeptTheme.paper,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (page.items.isEmpty)
                    Text(
                      'No pending requests.',
                      style: GoogleFonts.manrope(color: KeptTheme.mist),
                    )
                  else
                    ...page.items.map(
                      (req) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          req.displayName,
                          style: GoogleFonts.manrope(
                            color: KeptTheme.paper,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          'Wants to join',
                          style: GoogleFonts.manrope(color: KeptTheme.mist),
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
                              icon: const Icon(
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
                              icon: const Icon(
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
      backgroundColor: KeptTheme.panel,
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
                    kept ? 'Nice — add a note?' : 'What happened?',
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: KeptTheme.paper,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Optional note stays in this room. Sharing to the public feed is your choice.',
                    style: GoogleFonts.manrope(
                      color: KeptTheme.mist,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    style: const TextStyle(color: KeptTheme.paper),
                    decoration: InputDecoration(
                      hintText: kept
                          ? 'Finished after gym…'
                          : 'Stress day, slipped once…',
                      hintStyle: const TextStyle(color: KeptTheme.mist),
                      filled: true,
                      fillColor: KeptTheme.ink,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: KeptTheme.line),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  KeptNativeSwitchTile(
                    value: shareToFeed,
                    title: 'Share to public feed',
                    subtitle: 'Only then it appears on Home for everyone.',
                    onChanged: (v) => setModalState(() => shareToFeed = v),
                  ),
                  const SizedBox(height: 8),
                  KeptPrimaryButton(
                    label: kept ? 'Post: I kept it' : 'Post: I broke it',
                    onPressed: () => Navigator.pop(context, (
                      note: controller.text.trim(),
                      shareToFeed: shareToFeed,
                    )),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
      backgroundColor: KeptTheme.void_,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF152019), KeptTheme.void_],
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
                          icon: const Icon(Icons.arrow_back_rounded),
                          color: KeptTheme.paper,
                        ),
                        Expanded(
                          child: Text(
                            room?.title ?? 'Vow room',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: KeptTheme.paper,
                            ),
                          ),
                        ),
                        if (board != null)
                          Text(
                            '${board.room.memberCount} in',
                            style: GoogleFonts.manrope(
                              color: KeptTheme.mist,
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
                        style: const TextStyle(color: KeptTheme.broke),
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
                                  'Today',
                                  !_canSeeChat(board)
                                      ? 'Chat'
                                      : _messages.isEmpty
                                      ? 'Chat'
                                      : 'Chat · ${_messages.length}',
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
                                color: KeptTheme.panel.withValues(alpha: 0.85),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: KeptTheme.line),
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
                                unselectedLabelColor: KeptTheme.mist,
                                labelStyle: GoogleFonts.sora(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                                tabs: [
                                  const Tab(text: 'Today'),
                                  Tab(
                                    text: !_canSeeChat(board)
                                        ? 'Chat'
                                        : _messages.isEmpty
                                        ? 'Chat'
                                        : 'Chat · ${_messages.length}',
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
                                  builder: (_) => MembersScreen(
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
                                          backgroundColor: KeptTheme.panel,
                                          title: Text(
                                            'Invite code',
                                            style: GoogleFonts.sora(
                                              color: KeptTheme.paper,
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
                                              child: const Text('Done'),
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

class _TodayTab extends StatefulWidget {
  const _TodayTab({
    required this.board,
    required this.busy,
    required this.myUserId,
    required this.onKept,
    required this.onBroke,
    required this.onJoin,
    required this.onSeeMembers,
    this.onCreateInvite,
    this.onReviewRequests,
  });

  final RoomBoard board;
  final bool busy;
  final String myUserId;
  final VoidCallback onKept;
  final VoidCallback onBroke;
  final Future<bool> Function({String? inviteCode}) onJoin;
  final VoidCallback onSeeMembers;
  final VoidCallback? onCreateInvite;
  final VoidCallback? onReviewRequests;

  @override
  State<_TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<_TodayTab> {
  final _inviteController = TextEditingController();

  @override
  void dispose() {
    _inviteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final board = widget.board;
    final room = board.room;
    final busy = widget.busy;
    final percent = keptSharePercent(
      kept: board.keptCount,
      broken: board.brokenCount,
    );
    final progress = percent == null ? 0.0 : percent / 100;
    final quietLabel = board.pendingCount == 1
        ? '1 still quiet'
        : '${board.pendingCount} still quiet';
    final verdict = percent == null ? 'No one has spoken' : '$percent% kept';
    final myStatus = widget.myUserId.isEmpty
        ? null
        : board.members
              .where((m) => m.userId == widget.myUserId)
              .map((m) => m.kept)
              .firstOrNull;
    final alreadyIn = board.isMember && myStatus != null;
    final policyLabel = switch (room.joinPolicy) {
      'approval' => 'Admin approval',
      'invite' => 'Invite only',
      'closed' => 'Closed',
      _ => 'Open to join',
    };
    final pendingRequests = board.pendingRequestCount;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            children: [
              Row(
                children: [
                  KeptChip(
                    label: policyLabel,
                    color: room.joinPolicy == 'open'
                        ? KeptTheme.kept
                        : KeptTheme.pending,
                  ),
                  if (room.isOfficial) ...[
                    const SizedBox(width: 8),
                    const KeptChip(label: 'Official', color: KeptTheme.accent),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                room.rule,
                style: GoogleFonts.manrope(
                  color: KeptTheme.mist,
                  height: 1.45,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: KeptTheme.panel,
                  border: Border.all(color: KeptTheme.line),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 7,
                            backgroundColor: KeptTheme.line,
                            color: KeptTheme.kept,
                          ),
                          Center(
                            child: Text(
                              percent == null ? '—' : '$percent%',
                              style: GoogleFonts.sora(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: KeptTheme.paper,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$verdict · $quietLabel',
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w700,
                              color: KeptTheme.paper,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Today · ${board.dayKey}',
                            style: GoogleFonts.manrope(
                              color: KeptTheme.mist,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Yesterday · ${board.yesterdayKeptCount} kept · ${board.yesterdayBrokenCount} broke',
                            style: GoogleFonts.manrope(
                              color: KeptTheme.mist,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!board.isMember) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: KeptTheme.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: KeptTheme.accent.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        board.myRequestStatus == 'pending'
                            ? 'Waiting for admin approval'
                            : 'Join to check in and chat',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w700,
                          color: KeptTheme.paper,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        switch (room.joinPolicy) {
                          'approval' =>
                            'Request access. An admin decides who gets in.',
                          'invite' =>
                            'Enter the invite code an admin shared with you.',
                          'closed' => 'This vow is not accepting members.',
                          _ => 'Open vow — tap join to step in.',
                        },
                        style: GoogleFonts.manrope(
                          color: KeptTheme.mist,
                          fontSize: 13,
                        ),
                      ),
                      if (room.joinPolicy == 'invite' &&
                          board.myRequestStatus != 'pending') ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: _inviteController,
                          textCapitalization: TextCapitalization.characters,
                          style: const TextStyle(
                            color: KeptTheme.paper,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Invite code',
                            hintStyle: const TextStyle(
                              color: KeptTheme.mist,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: KeptTheme.ink,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: KeptTheme.line,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: KeptTheme.line,
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (room.joinPolicy != 'closed' &&
                          board.myRequestStatus != 'pending') ...[
                        const SizedBox(height: 12),
                        KeptPrimaryButton(
                          label: room.joinPolicy == 'approval'
                              ? 'Request to join'
                              : room.joinPolicy == 'invite'
                              ? 'Join with code'
                              : 'Join this vow',
                          onPressed: busy
                              ? null
                              : () {
                                  final code = _inviteController.text.trim();
                                  if (room.joinPolicy == 'invite') {
                                    if (code.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Enter an invite code to join.',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    widget.onJoin(inviteCode: code);
                                  } else {
                                    widget.onJoin();
                                  }
                                },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              if (board.isAdmin) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (widget.onCreateInvite != null)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onCreateInvite,
                          child: const Text('Invite code'),
                        ),
                      ),
                    if (widget.onCreateInvite != null &&
                        widget.onReviewRequests != null)
                      const SizedBox(width: 8),
                    if (widget.onReviewRequests != null)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onReviewRequests,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Requests'),
                              if (pendingRequests > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: KeptTheme.broke,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    pendingRequests > 99
                                        ? '99+'
                                        : '$pendingRequests',
                                    style: GoogleFonts.sora(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: KeptTheme.paper,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 18),
              if (board.pendingCount > 0) ...[
                Text(
                  quietLabel,
                  style: GoogleFonts.sora(
                    fontWeight: FontWeight.w700,
                    color: KeptTheme.pending,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final name in board.silentNames)
                      KeptChip(label: name, color: KeptTheme.pending),
                  ],
                ),
                if (board.silentNames.length < board.pendingCount) ...[
                  const SizedBox(height: 8),
                  Text(
                    'and ${board.pendingCount - board.silentNames.length} more',
                    style: GoogleFonts.manrope(
                      color: KeptTheme.mist,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
              ],
              Row(
                children: [
                  Text(
                    'Members',
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w700,
                      color: KeptTheme.paper,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: widget.onSeeMembers,
                    child: Text(
                      'See all (${board.memberTotal})',
                      style: GoogleFonts.manrope(
                        color: KeptTheme.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...board.members.map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _MemberTile(member: m),
                ),
              ),
            ],
          ),
        ),
        if (board.isMember)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              color: KeptTheme.panel,
              border: Border(top: BorderSide(color: KeptTheme.line)),
            ),
            child: alreadyIn
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color:
                          (myStatus == true ? KeptTheme.kept : KeptTheme.broke)
                              .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            (myStatus == true
                                    ? KeptTheme.kept
                                    : KeptTheme.broke)
                                .withValues(alpha: 0.35),
                      ),
                    ),
                    child: Text(
                      myStatus == true
                          ? 'Logged: kept it · see you tomorrow'
                          : 'Logged: broke it · see you tomorrow',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w700,
                        color: myStatus == true
                            ? KeptTheme.kept
                            : KeptTheme.broke,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: keptUsesNativeCupertino
                            ? SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: CNButton(
                                  label: 'I kept it',
                                  onPressed: busy ? null : widget.onKept,
                                  enabled: !busy,
                                  tint: KeptTheme.kept,
                                  height: 48,
                                  style: CNButtonStyle.filled,
                                ),
                              )
                            : FilledButton(
                                onPressed: busy ? null : widget.onKept,
                                style: FilledButton.styleFrom(
                                  backgroundColor: KeptTheme.kept,
                                  foregroundColor: KeptTheme.void_,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'I kept it',
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: keptUsesNativeCupertino
                            ? SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: CNButton(
                                  label: 'I broke it',
                                  onPressed: busy ? null : widget.onBroke,
                                  enabled: !busy,
                                  tint: KeptTheme.broke,
                                  height: 48,
                                  style: CNButtonStyle.borderedProminent,
                                ),
                              )
                            : OutlinedButton(
                                onPressed: busy ? null : widget.onBroke,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: KeptTheme.broke,
                                  side: const BorderSide(
                                    color: KeptTheme.broke,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'I broke it',
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
          ),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member});

  final MemberDayStatus member;

  @override
  Widget build(BuildContext context) {
    final Color tone;
    final String status;
    if (member.kept == null) {
      tone = KeptTheme.pending;
      status = 'Still quiet';
    } else if (member.kept!) {
      tone = KeptTheme.kept;
      status = 'Kept';
    } else {
      tone = KeptTheme.broke;
      status = 'Broke';
    }

    final roleLabel = switch (member.role) {
      'owner' => 'Owner',
      'admin' => 'Admin',
      _ => null,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KeptTheme.panel.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KeptTheme.line),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: tone.withValues(alpha: 0.2),
            child: Text(
              member.displayName.isNotEmpty
                  ? member.displayName[0].toUpperCase()
                  : '?',
              style: GoogleFonts.sora(
                fontWeight: FontWeight.w700,
                color: tone,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.displayName,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    color: KeptTheme.paper,
                  ),
                ),
                if (roleLabel != null)
                  Text(
                    roleLabel,
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: KeptTheme.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (member.note != null && member.note!.isNotEmpty)
                  Text(
                    member.note!,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: KeptTheme.mist,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            status,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: tone,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatTab extends StatelessWidget {
  const _ChatTab({
    required this.locked,
    required this.joinPolicy,
    required this.messages,
    required this.scrollController,
    required this.textController,
    required this.sending,
    required this.onSend,
    required this.onJoin,
    required this.myUserId,
  });

  final bool locked;
  final String joinPolicy;
  final List<VowMessage> messages;
  final ScrollController scrollController;
  final TextEditingController textController;
  final bool sending;
  final VoidCallback onSend;
  final VoidCallback onJoin;
  final String myUserId;

  @override
  Widget build(BuildContext context) {
    if (locked) {
      final hint = switch (joinPolicy) {
        'invite' => 'This vow is invite-only. Join with a code to see chat.',
        'approval' => 'Request to join and wait for approval to see chat.',
        'closed' => 'Only members can see this chat.',
        _ => 'Join this vow to see chat.',
      };
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 40,
                color: KeptTheme.mist.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 14),
              Text(
                'Chat is for members',
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w700,
                  color: KeptTheme.paper,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                hint,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: KeptTheme.mist,
                  height: 1.45,
                ),
              ),
              if (joinPolicy != 'closed') ...[
                const SizedBox(height: 18),
                KeptPrimaryButton(
                  label: joinPolicy == 'approval'
                      ? 'Request to join'
                      : joinPolicy == 'invite'
                      ? 'Enter invite on Today'
                      : 'Join this vow',
                  onPressed: onJoin,
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No messages yet.\nCheck in or say hi — the room will light up.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        color: KeptTheme.mist,
                        height: 1.45,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return _MessageBubble(
                      message: messages[index],
                      isMine: messages[index].userId == myUserId,
                    );
                  },
                ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            12,
            10,
            12,
            10 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: const BoxDecoration(
            color: KeptTheme.panel,
            border: Border(top: BorderSide(color: KeptTheme.line)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  minLines: 1,
                  maxLines: 4,
                  style: const TextStyle(color: KeptTheme.paper),
                  decoration: InputDecoration(
                    hintText: 'Encourage someone, vent, share a tip…',
                    hintStyle: const TextStyle(color: KeptTheme.mist),
                    filled: true,
                    fillColor: KeptTheme.ink,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: KeptTheme.line),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: KeptTheme.line),
                    ),
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
              const SizedBox(width: 8),
              KeptNativeIconButton(
                symbol: 'paperplane.fill',
                onPressed: sending ? null : onSend,
                size: 44,
                style: CNButtonStyle.filled,
                tint: KeptTheme.accent,
                materialIcon: Icons.send_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.isMine});

  final VowMessage message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final isSystem = message.kind != 'chat';
    if (isSystem) {
      final color = switch (message.kind) {
        'kept' => KeptTheme.kept,
        'broke' => KeptTheme.broke,
        'joined' => KeptTheme.pending,
        _ => KeptTheme.mist,
      };
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: color.withValues(alpha: 0.28)),
            ),
            child: Text(
              message.body,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isMine
              ? KeptTheme.accent.withValues(alpha: 0.18)
              : KeptTheme.panel,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
          border: Border.all(
            color: isMine
                ? KeptTheme.accent.withValues(alpha: 0.35)
                : KeptTheme.line,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.displayName,
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isMine ? KeptTheme.accent : KeptTheme.mist,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.body,
              style: GoogleFonts.manrope(
                color: KeptTheme.paper,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
