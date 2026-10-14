part of '../home_view.dart';

class _OpenVowsCard extends StatelessWidget {
  const _OpenVowsCard({
    required this.vows,
    required this.checkingRoomId,
    required this.onCheckIn,
  });

  final List<OpenVow> vows;
  final int? checkingRoomId;
  final void Function(OpenVow vow, bool kept) onCheckIn;

  @override
  Widget build(BuildContext context) {
    final countLabel = LocaleKeys.vowsStillOpen.plural(vows.length);
    final border = BorderSide(
      color: KeptTheme.pending.withValues(alpha: 0.45),
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: border,
    );
    return Material(
      color: context.kept.panel,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          iconColor: KeptTheme.pending,
          collapsedIconColor: KeptTheme.pending,
          backgroundColor: context.kept.panel,
          collapsedBackgroundColor: context.kept.panel,
          shape: shape,
          collapsedShape: shape,
          title: Text(
            countLabel,
            style: GoogleFonts.sora(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              color: context.kept.paper,
            ),
          ),
          subtitle: Text(
            LocaleKeys.closeTheDayHere.tr(),
            style: GoogleFonts.manrope(fontSize: 13, color: context.kept.mist),
          ),
          children: [
            for (final vow in vows) ...[
              _OpenVowRow(
                vow: vow,
                busy: checkingRoomId != null,
                onKept: checkingRoomId == null
                    ? () => onCheckIn(vow, true)
                    : null,
                onBroke: checkingRoomId == null
                    ? () => onCheckIn(vow, false)
                    : null,
              ),
              if (vow != vows.last)
                Divider(height: 20, color: context.kept.line),
            ],
          ],
        ),
      ),
    );
  }
}

class _OpenVowRow extends StatelessWidget {
  const _OpenVowRow({
    required this.vow,
    required this.busy,
    required this.onKept,
    required this.onBroke,
  });

  final OpenVow vow;
  final bool busy;
  final VoidCallback? onKept;
  final VoidCallback? onBroke;

  @override
  Widget build(BuildContext context) {
    final percent = KeptShare.percent(
      kept: vow.keptCount,
      broken: vow.brokenCount,
    );
    final verdict = percent == null
        ? LocaleKeys.noOneHasSpoken.tr()
        : LocaleKeys.percentKept.tr(
            namedArgs: {'percent': (percent).toString()},
          );
    final quiet = LocaleKeys.stillQuiet.plural(vow.pendingCount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vow.title,
          style: GoogleFonts.sora(
            fontWeight: FontWeight.w700,
            color: context.kept.paper,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          vow.rule,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(fontSize: 12, color: context.kept.mist),
        ),
        const SizedBox(height: 6),
        Text(
          '$verdict · $quiet',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: KeptTheme.pending,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: busy ? null : onKept,
                style: FilledButton.styleFrom(
                  backgroundColor: KeptTheme.kept,
                  foregroundColor: context.kept.void_,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  LocaleKeys.iKeptIt.tr(),
                  style: GoogleFonts.sora(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: busy ? null : onBroke,
                style: OutlinedButton.styleFrom(
                  foregroundColor: KeptTheme.broke,
                  side: BorderSide(color: KeptTheme.broke),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  LocaleKeys.iBrokeIt.tr(),
                  style: GoogleFonts.sora(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
