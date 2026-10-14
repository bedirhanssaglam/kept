part of '../home_view.dart';

class _PostActions extends StatelessWidget {
  const _PostActions({
    required this.card,
    required this.onLike,
    required this.onComment,
    this.trailing,
  });

  final HomeCard card;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onLike,
              child: Icon(
                card.likedByMe
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: card.likedByMe ? KeptTheme.broke : context.kept.paper,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: onComment,
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: context.kept.paper,
                size: 24,
              ),
            ),
            if (trailing != null) ...[const Spacer(), trailing!],
          ],
        ),
        if (card.likeCount > 0) ...[
          const SizedBox(height: 8),
          Text(
            LocaleKeys.likeCount.plural(card.likeCount),
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              color: context.kept.paper,
              fontSize: 13,
            ),
          ),
        ],
        if (card.commentCount > 0) ...[
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onComment,
            child: Text(
              LocaleKeys.viewComments.plural(card.commentCount),
              style: GoogleFonts.manrope(
                color: context.kept.mist,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ActivityPost extends StatelessWidget {
  const _ActivityPost({
    required this.card,
    required this.onOpenRoom,
    required this.onLike,
    required this.onComment,
  });

  final HomeCard card;
  final VoidCallback onOpenRoom;
  final VoidCallback onLike;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    final ink = light ? context.kept.paper : Colors.white;
    final item = card.activity!;
    final style = _PostVisual.ofActivity(item.kind);
    final mediaH = KeptBreakpoints.feedMediaHeight(context, ratio: 0.92);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 1, color: context.kept.line),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 10),
          child: Row(
            children: [
              _Avatar(letter: item.displayName, color: style.color),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.displayName,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item.roomTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: context.kept.mist,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _FeedChrome.relativeTime(item.createdAt.toLocal()),
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: context.kept.mist,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: onLike,
          onTap: onOpenRoom,
          child: Container(
            height: mediaH,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _FeedChrome.wash(context, style.color),
              ),
              borderRadius: BorderRadius.circular(
                context.keptIsWide ? 16 : 0,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  bottom: -40,
                  child: Icon(
                    style.icon,
                    size: 220,
                    color: ink.withValues(alpha: 0.1),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: style.color.withValues(
                            alpha: light ? 0.16 : 0.22,
                          ),
                        ),
                        child: Icon(
                          style.icon,
                          size: 42,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Text(
                          style.headline,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sora(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: ink,
                            height: 1.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostActions(
                card: card,
                onLike: onLike,
                onComment: onComment,
                trailing: KeptChip(
                  label: CategoryStyle.of(context, item.roomCategory).label,
                  color: CategoryStyle.of(context, item.roomCategory).color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                ActivityLine.of(
                  kind: item.kind,
                  name: item.displayName,
                  body: item.body,
                ),
                style: GoogleFonts.manrope(
                  color: context.kept.paper.withValues(alpha: 0.92),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onOpenRoom,
                child: Text(
                  LocaleKeys.openRoom.tr(),
                  style: GoogleFonts.manrope(
                    color: context.kept.mist,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
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

class _ArticlePost extends StatelessWidget {
  const _ArticlePost({
    required this.card,
    required this.onOpen,
  });

  final HomeCard card;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final post = card.article!;
    final visual = _PostVisual.ofTopic(post.topic);
    final light = Theme.of(context).brightness == Brightness.light;
    final ink = light ? context.kept.paper : Colors.white;
    final mediaH = KeptBreakpoints.feedMediaHeight(context, ratio: 0.85);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 1, color: context.kept.line),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 10),
          child: Row(
            children: [
              _Avatar(letter: 'K', color: visual.color),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.keptJournal.tr(),
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      post.topic.toUpperCase(),
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        letterSpacing: 1.1,
                        color: context.kept.mist,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _FeedChrome.relativeTime(post.publishedAt.toLocal()),
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: context.kept.mist,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onOpen,
          child: Container(
            height: mediaH,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _FeedChrome.wash(context, visual.color),
              ),
              borderRadius: BorderRadius.circular(
                context.keptIsWide ? 16 : 0,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KeptChip(label: LocaleKeys.article.tr(), color: visual.color),
                const Spacer(),
                Text(
                  post.title,
                  style: GoogleFonts.sora(
                    fontSize: context.keptIsWide ? 28 : 30,
                    fontWeight: FontWeight.w700,
                    color: ink,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  post.excerpt,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    height: 1.45,
                    color: ink.withValues(alpha: 0.88),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.keptJournal.tr()} ',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                    TextSpan(
                      text: post.excerpt,
                      style: GoogleFonts.manrope(
                        color: context.kept.paper.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onOpen,
                child: Text(
                  LocaleKeys.readArticle.tr(),
                  style: GoogleFonts.manrope(
                    color: KeptTheme.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.letter, required this.color});

  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ch = letter.isNotEmpty ? letter.substring(0, 1).toUpperCase() : '?';
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        ch,
        style: GoogleFonts.sora(
          fontWeight: FontWeight.w700,
          color: color,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _PostVisual {
  const _PostVisual({
    required this.icon,
    required this.color,
    required this.gradient,
    required this.headline,
  });

  final IconData icon;
  final Color color;
  final List<Color> gradient;
  final String headline;

  static _PostVisual ofActivity(String kind) {
    switch (kind) {
      case VowActivityKind.kept:
        return _PostVisual(
          icon: Icons.check_rounded,
          color: KeptTheme.kept,
          gradient: const [Color(0xFF1B3D2F), Color(0xFF0F1A14)],
          headline: LocaleKeys.keptIt.tr(),
        );
      case VowActivityKind.broke:
        return _PostVisual(
          icon: Icons.close_rounded,
          color: KeptTheme.broke,
          gradient: const [Color(0xFF3D1F1C), Color(0xFF140E0D)],
          headline: LocaleKeys.brokeIt.tr(),
        );
      case VowActivityKind.joined:
        return _PostVisual(
          icon: Icons.person_add_alt_1_rounded,
          color: KeptTheme.pending,
          gradient: const [Color(0xFF3A3218), Color(0xFF14110A)],
          headline: LocaleKeys.steppedIn.tr(),
        );
      default:
        return _PostVisual(
          icon: Icons.chat_bubble_rounded,
          color: KeptTheme.mist,
          gradient: const [Color(0xFF1C2621), Color(0xFF0C100E)],
          headline: LocaleKeys.saidSomething.tr(),
        );
    }
  }

  static _PostVisual ofTopic(String topic) {
    switch (topic) {
      case BlogTopic.water:
        return _PostVisual(
          icon: Icons.water_drop_rounded,
          color: const Color(0xFF5EEAD4),
          gradient: const [Color(0xFF12353A), Color(0xFF0A1416)],
          headline: LocaleKeys.categoryWater.tr(),
        );
      case VowCategory.focus:
        return _PostVisual(
          icon: Icons.center_focus_strong_rounded,
          color: const Color(0xFFFDE68A),
          gradient: const [Color(0xFF3A3214), Color(0xFF12100A)],
          headline: LocaleKeys.categoryFocus.tr(),
        );
      case VowCategory.move:
        return _PostVisual(
          icon: Icons.directions_walk_rounded,
          color: const Color(0xFF93C5FD),
          gradient: const [Color(0xFF1A2A3D), Color(0xFF0C1218)],
          headline: LocaleKeys.categoryMove.tr(),
        );
      default:
        return _PostVisual(
          icon: Icons.auto_awesome_rounded,
          color: KeptTheme.accent,
          gradient: const [Color(0xFF243528), Color(0xFF0E1411)],
          headline: LocaleKeys.categoryHabits.tr(),
        );
    }
  }
}

abstract final class _FeedChrome {
  static List<Color> wash(BuildContext context, Color accent) {
    final light = Theme.of(context).brightness == Brightness.light;
    if (light) {
      return [
        accent.withValues(alpha: 0.28),
        context.kept.wash,
      ];
    }
    return [
      Color.alphaBlend(accent.withValues(alpha: 0.45), const Color(0xFF121816)),
      const Color(0xFF0C100E),
    ];
  }

  static String relativeTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return LocaleKeys.timeNow.tr();
    if (diff.inMinutes < 60) {
      return LocaleKeys.timeMinutes.tr(
        namedArgs: {'count': (diff.inMinutes).toString()},
      );
    }
    if (diff.inHours < 24) {
      return LocaleKeys.timeHours.tr(
        namedArgs: {'count': (diff.inHours).toString()},
      );
    }
    if (diff.inDays < 7) {
      return LocaleKeys.timeDays.tr(
        namedArgs: {'count': (diff.inDays).toString()},
      );
    }
    return '${t.day}.${t.month}';
  }
}
