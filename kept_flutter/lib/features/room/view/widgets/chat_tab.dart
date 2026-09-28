part of '../room_view.dart';

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
        VowPolicy.invite => context.l10n.chatInviteOnly,
        VowPolicy.approval => context.l10n.chatNeedsApproval,
        VowPolicy.closed => context.l10n.chatMembersOnly,
        _ => context.l10n.chatJoinToSee,
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
                color: context.kept.mist.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 14),
              Text(
                context.l10n.chatForMembers,
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w700,
                  color: context.kept.paper,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                hint,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: context.kept.mist,
                  height: 1.45,
                ),
              ),
              if (joinPolicy != 'closed') ...[
                const SizedBox(height: 18),
                KeptPrimaryButton(
                  label: joinPolicy == VowPolicy.approval
                      ? context.l10n.requestToJoin
                      : joinPolicy == VowPolicy.invite
                      ? context.l10n.enterInviteOnToday
                      : context.l10n.joinThisVow,
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
                      context.l10n.chatEmpty,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        color: context.kept.mist,
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
          decoration: BoxDecoration(
            color: context.kept.panel,
            border: Border(top: BorderSide(color: context.kept.line)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  minLines: 1,
                  maxLines: 4,
                  style: TextStyle(color: context.kept.paper),
                  decoration: InputDecoration(
                    hintText: context.l10n.chatHint,
                    hintStyle: TextStyle(color: context.kept.mist),
                    filled: true,
                    fillColor: context.kept.ink,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.kept.line),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.kept.line),
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
        _ => context.kept.mist,
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
              activityLine(
                context.l10n,
                kind: message.kind,
                name: message.displayName,
                body: message.body,
              ),
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
              : context.kept.panel,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
          border: Border.all(
            color: isMine
                ? KeptTheme.accent.withValues(alpha: 0.35)
                : context.kept.line,
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
                color: isMine ? KeptTheme.accent : context.kept.mist,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.body,
              style: GoogleFonts.manrope(
                color: context.kept.paper,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
