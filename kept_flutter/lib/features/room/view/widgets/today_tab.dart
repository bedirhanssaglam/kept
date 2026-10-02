part of '../room_view.dart';

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
    final l10n = context.l10n;
    final quietLabel = l10n.stillQuiet(board.pendingCount);
    final verdict = percent == null
        ? l10n.noOneHasSpoken
        : l10n.percentKept(percent);
    final myStatus = widget.myUserId.isEmpty
        ? null
        : board.members
              .where((m) => m.userId == widget.myUserId)
              .map((m) => m.kept)
              .firstOrNull;
    final alreadyIn = board.isMember && myStatus != null;
    final today = KeptDay.key();
    final started = vowHasStarted(room.startsOn, today);
    final ended = vowHasEnded(room.startsOn, room.durationDays, today);
    final openToday = started && !ended;
    final policyLabel = vowPolicyChip(l10n, room.joinPolicy);
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
                    color: room.joinPolicy == VowPolicy.open
                        ? KeptTheme.kept
                        : KeptTheme.pending,
                  ),
                  if (room.isOfficial) ...[
                    const SizedBox(width: 8),
                    KeptChip(label: l10n.official, color: KeptTheme.accent),
                  ],
                  const SizedBox(width: 8),
                  KeptChip(
                    label: vowLengthLabel(l10n, room.durationDays),
                    color: context.kept.mist,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                room.rule,
                style: GoogleFonts.manrope(
                  color: context.kept.mist,
                  height: 1.45,
                  fontSize: 14,
                ),
              ),
              if (!openToday) ...[
                const SizedBox(height: 8),
                Text(
                  ended ? l10n.vowFinished : l10n.vowNotStarted,
                  style: GoogleFonts.manrope(
                    color: KeptTheme.pending,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.kept.panel,
                  border: Border.all(color: context.kept.line),
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
                            backgroundColor: context.kept.line,
                            color: KeptTheme.kept,
                          ),
                          Center(
                            child: Text(
                              percent == null ? '—' : '$percent%',
                              style: GoogleFonts.sora(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: context.kept.paper,
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
                              color: context.kept.paper,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.todayLine(board.dayKey),
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            l10n.yesterdayLine(
                              board.yesterdayKeptCount,
                              board.yesterdayBrokenCount,
                            ),
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
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
                            ? l10n.waitingApproval
                            : l10n.joinToCheckIn,
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w700,
                          color: context.kept.paper,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        switch (room.joinPolicy) {
                          VowPolicy.approval => l10n.joinApprovalHelp,
                          VowPolicy.invite => l10n.joinInviteHelp,
                          VowPolicy.closed => l10n.joinClosedHelp,
                          _ => l10n.joinOpenHelp,
                        },
                        style: GoogleFonts.manrope(
                          color: context.kept.mist,
                          fontSize: 13,
                        ),
                      ),
                      if (room.joinPolicy == VowPolicy.invite &&
                          board.myRequestStatus != 'pending') ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: _inviteController,
                          textCapitalization: TextCapitalization.characters,
                          style: TextStyle(
                            color: context.kept.paper,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            hintText: context.l10n.inviteCode,
                            hintStyle: TextStyle(
                              color: context.kept.mist,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: context.kept.ink,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: context.kept.line,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: context.kept.line,
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (room.joinPolicy != VowPolicy.closed &&
                          board.myRequestStatus != 'pending') ...[
                        const SizedBox(height: 12),
                        KeptPrimaryButton(
                          label: room.joinPolicy == VowPolicy.approval
                              ? l10n.requestToJoin
                              : room.joinPolicy == VowPolicy.invite
                              ? l10n.joinWithCode
                              : l10n.joinThisVow,
                          onPressed: busy
                              ? null
                              : () {
                                  final code = _inviteController.text.trim();
                                  if (room.joinPolicy == VowPolicy.invite) {
                                    if (code.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            l10n.enterInviteToJoin,
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
                          child: Text(l10n.inviteCode),
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
                              Text(l10n.requests),
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
                                      color: context.kept.paper,
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
                    l10n.andNMore(
                      board.pendingCount - board.silentNames.length,
                    ),
                    style: GoogleFonts.manrope(
                      color: context.kept.mist,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
              ],
              Row(
                children: [
                  Text(
                    l10n.members,
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w700,
                      color: context.kept.paper,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: widget.onSeeMembers,
                    child: Text(
                      l10n.seeAllMembers(board.memberTotal),
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
            decoration: BoxDecoration(
              color: context.kept.panel,
              border: Border(top: BorderSide(color: context.kept.line)),
            ),
            child: !openToday
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      ended ? l10n.vowFinished : l10n.vowNotStarted,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.pending,
                      ),
                    ),
                  )
                : alreadyIn
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
                      myStatus == true ? l10n.loggedKept : l10n.loggedBroke,
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
                                  label: l10n.iKeptIt,
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
                                  foregroundColor: context.kept.void_,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  l10n.iKeptIt,
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
                                  label: l10n.iBrokeIt,
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
                                  side: BorderSide(
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
                                  l10n.iBrokeIt,
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
      status = context.l10n.statusQuiet;
    } else if (member.kept!) {
      tone = KeptTheme.kept;
      status = context.l10n.statusKept;
    } else {
      tone = KeptTheme.broke;
      status = context.l10n.statusBroke;
    }

    final roleLabel = switch (member.role) {
      VowRole.owner => context.l10n.roleOwner,
      VowRole.admin => context.l10n.roleAdmin,
      _ => null,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.kept.panel.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.kept.line),
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
                    color: context.kept.paper,
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
                      color: context.kept.mist,
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
