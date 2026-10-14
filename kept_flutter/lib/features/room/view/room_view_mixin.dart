part of 'room_view.dart';

mixin _RoomViewMixin on ConsumerState<RoomView> {
  VowRepository get _repo => ref.read(VowRepository.provider);
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

  bool _canSeeChat(RoomBoard? board) {
    if (board == null) return false;
    return board.isMember || board.room.joinPolicy == VowPolicy.open;
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
      final ok = await const SignInSheet().show(context);
      if (!ok) return false;
    }
    if (_board?.isMember == true) return true;
    return _offerJoin();
  }

  Future<bool> _offerJoin({String? inviteCode}) async {
    final board = _board;
    if (board == null) return false;
    final policy = board.room.joinPolicy;

    if (policy == VowPolicy.closed) {
      _showSnack(LocaleKeys.vowClosed.tr(), background: KeptTheme.broke);
      return false;
    }

    if (policy == VowPolicy.approval) {
      if (board.myRequestStatus == 'pending') {
        _showSnack(LocaleKeys.requestPending.tr());
        return false;
      }
      try {
        await _repo.requestJoin(widget.roomId);
        final refreshed = await _repo.getBoard(widget.roomId);
        if (mounted) setState(() => _board = refreshed);
        _showSnack(LocaleKeys.requestSent.tr());
      } catch (e) {
        _showSnack('$e', background: KeptTheme.broke);
      }
      return false;
    }

    if (policy == VowPolicy.invite) {
      final code = (inviteCode ?? await _InviteCodeDialog.ask(context))?.trim();
      if (code == null || code.isEmpty) return false;
      try {
        final next = await _repo.joinWithInvite(code: code);
        if (mounted) setState(() => _board = next);
        if (next.isMember) _listenChat();
        return next.isMember;
      } catch (e) {
        _showSnack('$e', background: KeptTheme.broke);
        return false;
      }
    }

    try {
      final next = await _repo.joinRoom(widget.roomId);
      if (mounted) setState(() => _board = next);
      if (next.isMember) _listenChat();
      return next.isMember;
    } catch (e) {
      _showSnack('$e', background: KeptTheme.broke);
      return false;
    }
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
        builder: (sheetContext) {
          return _JoinRequestsSheet(
            page: page,
            onReject: (requestId) async {
              await _repo.reviewJoinRequest(
                requestId: requestId,
                approve: false,
              );
              if (sheetContext.mounted) Navigator.pop(sheetContext);
              final board = await _repo.getBoard(widget.roomId);
              if (mounted) setState(() => _board = board);
            },
            onApprove: (requestId) async {
              final board = await _repo.reviewJoinRequest(
                requestId: requestId,
                approve: true,
              );
              if (sheetContext.mounted) Navigator.pop(sheetContext);
              if (mounted) setState(() => _board = board);
            },
          );
        },
      );
    } catch (e) {
      _showSnack('$e', background: KeptTheme.broke);
    }
  }

  Future<void> _checkIn(bool kept) async {
    setState(() => _busy = true);
    try {
      final ok = await _ensureMember();
      if (!ok || !mounted) return;

      final draft = await _CheckInSheet.show(context, kept);
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
      _showSnack('$e', background: KeptTheme.broke);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _createInvite() async {
    try {
      final code = await _repo.createInviteCode(widget.roomId);
      if (!mounted) return;
      await _InviteCodeDialog.show(context, code);
    } catch (e) {
      _showSnack('$e', background: KeptTheme.broke);
    }
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
      _showSnack('$e', background: KeptTheme.broke);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _showSnack(String message, {Color? background}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: background),
    );
  }
}
