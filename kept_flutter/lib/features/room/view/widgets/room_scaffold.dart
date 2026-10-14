part of '../room_view.dart';

class _RoomScaffold extends StatelessWidget {
  const _RoomScaffold({
    required this.board,
    required this.error,
    required this.messages,
    required this.tabs,
    required this.busy,
    required this.sending,
    required this.chatScroll,
    required this.chatController,
    required this.myUserId,
    required this.canSeeChat,
    required this.onKept,
    required this.onBroke,
    required this.onJoin,
    required this.onSend,
    required this.onSeeMembers,
    required this.onCreateInvite,
    required this.onReviewRequests,
  });

  final RoomBoard? board;
  final String? error;
  final List<VowMessage> messages;
  final TabController tabs;
  final bool busy;
  final bool sending;
  final ScrollController chatScroll;
  final TextEditingController chatController;
  final String myUserId;
  final bool Function(RoomBoard? board) canSeeChat;
  final VoidCallback onKept;
  final VoidCallback onBroke;
  final Future<bool> Function({String? inviteCode}) onJoin;
  final VoidCallback onSend;
  final VoidCallback onSeeMembers;
  final VoidCallback onCreateInvite;
  final VoidCallback onReviewRequests;

  @override
  Widget build(BuildContext context) {
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
                          icon: const Icon(Icons.arrow_back_rounded),
                          color: context.kept.paper,
                        ),
                        Expanded(
                          child: Text(
                            room?.title ?? LocaleKeys.vowRoom.tr(),
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
                            LocaleKeys.inRoom.tr(
                              namedArgs: {
                                'count': (board!.room.memberCount).toString(),
                              },
                            ),
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        error!,
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
                      child: _RoomTabs(
                        board: board!,
                        messages: messages,
                        tabs: tabs,
                        canSeeChat: canSeeChat(board),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabs,
                        children: [
                          _TodayTab(
                            board: board!,
                            busy: busy,
                            myUserId: myUserId,
                            onKept: onKept,
                            onBroke: onBroke,
                            onJoin: onJoin,
                            onSeeMembers: onSeeMembers,
                            onCreateInvite: board!.isAdmin
                                ? onCreateInvite
                                : null,
                            onReviewRequests: board!.isAdmin
                                ? onReviewRequests
                                : null,
                          ),
                          _ChatTab(
                            locked: !canSeeChat(board),
                            joinPolicy: board!.room.joinPolicy,
                            messages: messages,
                            scrollController: chatScroll,
                            textController: chatController,
                            sending: sending,
                            onSend: onSend,
                            onJoin: onJoin,
                            myUserId: myUserId,
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

class _RoomTabs extends StatelessWidget {
  const _RoomTabs({
    required this.board,
    required this.messages,
    required this.tabs,
    required this.canSeeChat,
  });

  final RoomBoard board;
  final List<VowMessage> messages;
  final TabController tabs;
  final bool canSeeChat;

  @override
  Widget build(BuildContext context) {
    final chatLabel = !canSeeChat || messages.isEmpty
        ? LocaleKeys.tabChat.tr()
        : LocaleKeys.tabChatCount.tr(
            namedArgs: {'count': messages.length.toString()},
          );

    if (keptUsesNativeCupertino) {
      return SizedBox(
        height: 36,
        width: double.infinity,
        child: CNSegmentedControl(
          labels: [LocaleKeys.tabToday.tr(), chatLabel],
          selectedIndex: tabs.index,
          onValueChanged: (i) {
            if (i == tabs.index) return;
            tabs.animateTo(i);
          },
          color: KeptTheme.accent,
          height: 36,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.kept.panel.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.kept.line),
      ),
      child: TabBar(
        controller: tabs,
        indicator: BoxDecoration(
          color: KeptTheme.accent.withValues(alpha: 0.18),
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
          Tab(text: LocaleKeys.tabToday.tr()),
          Tab(text: chatLabel),
        ],
      ),
    );
  }
}
