import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';

import '../../features/vows/domain/vow_labels.dart';
import '../theme/kept_theme.dart';
import 'kept_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import '../init/language/locale_keys.g.dart';

/// The public room card used on Discover and on the create-vow preview.
class VowRoomCard extends StatelessWidget {
  const VowRoomCard({
    super.key,
    required this.title,
    required this.rule,
    required this.category,
    required this.joinPolicy,
    required this.memberCount,
    required this.durationDays,
    required this.startsOn,
    this.onTap,
    this.showEnter = true,
    this.quiet = false,
  });

  factory VowRoomCard.room(
    VowRoom room, {
    Key? key,
    VoidCallback? onTap,
    bool showEnter = true,
  }) {
    return VowRoomCard(
      key: key,
      title: room.title,
      rule: room.rule,
      category: room.category,
      joinPolicy: room.joinPolicy,
      memberCount: room.memberCount,
      durationDays: room.durationDays,
      startsOn: room.startsOn,
      onTap: onTap,
      showEnter: showEnter,
    );
  }

  final String title;
  final String rule;
  final String category;
  final String joinPolicy;
  final int memberCount;
  final int durationDays;
  final String startsOn;
  final VoidCallback? onTap;
  final bool showEnter;
  final bool quiet;

  @override
  Widget build(BuildContext context) {
    final cat = CategoryStyle.of(context, category);
    final policy = VowLabels.policyShort(joinPolicy);
    final span = VowLabels.span(
      durationDays: durationDays,
      startsOn: startsOn,
    );
    final ink = quiet ? context.kept.mist : context.kept.paper;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: context.kept.panel.withValues(alpha: 0.92),
            border: Border.all(color: context.kept.line),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    KeptChip(label: cat.label, color: cat.color),
                    const SizedBox(width: 8),
                    KeptChip(label: policy, color: KeptTheme.pending),
                    const Spacer(),
                    Text(
                      LocaleKeys.memberCount.plural(memberCount),
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: context.kept.mist,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ink,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  rule,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    height: 1.4,
                    color: context.kept.mist,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    if (showEnter) ...[
                      Text(
                        LocaleKeys.enterRoom.tr(),
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: KeptTheme.accent,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: KeptTheme.accent,
                      ),
                    ],
                    const Spacer(),
                    Flexible(
                      child: Text(
                        span,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: context.kept.mist,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
