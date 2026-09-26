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
import 'blog_article_screen.dart';
import 'feed_comments_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onOpenRoom,
    this.bottomPadding = 24,
  });

  final ValueChanged<int> onOpenRoom;
  final double bottomPadding;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _repo = VowRepository();
  final _scroll = ScrollController();
  List<HomeCard> _feed = [];
  List<OpenVow> _open = [];
  int? _checkingRoom;
  String? _greetingName;
  bool _loading = true;
  bool _loadingMore = false;
  bool _feedHasMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    client.auth.authInfoListenable.addListener(_onAuth);
    refresh();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuth);
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onAuth() {
    _loadGreeting();
  }

  Future<void> _loadGreeting() async {
    if (!client.auth.isAuthenticated) {
      if (mounted) setState(() => _greetingName = null);
      return;
    }
    try {
      final profile = await _repo.getMyProfile();
      if (!mounted) return;
      setState(() => _greetingName = profile.displayName);
    } catch (_) {
      if (mounted) setState(() => _greetingName = null);
    }
  }

  void _onScroll() {
    if (!_feedHasMore || _loadingMore || _loading) return;
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    if (pos.pixels > pos.maxScrollExtent - 420) {
      _loadMoreFeed();
    }
  }

  Future<void> refresh() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final feedFuture = _repo.listHomeFeed(limit: 15, offset: 0);
      final openFuture = client.auth.isAuthenticated
          ? _repo.listOpenVows()
          : Future<List<OpenVow>>.value(const []);
      final HomeFeedPage feed;
      String? name;
      List<OpenVow> open;
      if (client.auth.isAuthenticated) {
        final results = await Future.wait([
          feedFuture,
          _repo.getMyProfile(),
          openFuture,
        ]);
        feed = results[0] as HomeFeedPage;
        name = (results[1] as KeptProfile).displayName;
        open = results[2] as List<OpenVow>;
      } else {
        feed = await feedFuture;
        open = const [];
      }
      if (!mounted) return;
      setState(() {
        _feed = List.of(feed.items);
        _feedHasMore = feed.hasMore;
        _open = List.of(open);
        _greetingName = name;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _loading = false;
      });
    }
  }

  Future<void> _loadMoreFeed() async {
    if (_loadingMore || !_feedHasMore) return;
    setState(() => _loadingMore = true);
    try {
      final page = await _repo.listHomeFeed(limit: 15, offset: _feed.length);
      if (!mounted) return;
      setState(() {
        _feed.addAll(page.items);
        _feedHasMore = page.hasMore;
        _loadingMore = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _checkOpen(OpenVow vow, bool kept) async {
    if (_checkingRoom != null) return;
    setState(() => _checkingRoom = vow.roomId);
    try {
      await _repo.checkIn(roomId: vow.roomId, kept: kept);
      if (!mounted) return;
      final open = await _repo.listOpenVows();
      if (!mounted) return;
      setState(() => _open = List.of(open));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
      );
    } finally {
      if (mounted) setState(() => _checkingRoom = null);
    }
  }

  void _replaceCard(HomeCard updated) {
    final i = _feed.indexWhere(
      (c) =>
          c.targetType == updated.targetType && c.targetId == updated.targetId,
    );
    if (i < 0) return;
    setState(() => _feed[i] = updated);
  }

  Future<void> _toggleLike(HomeCard card) async {
    if (!client.auth.isAuthenticated) {
      final ok = await showSignInSheet(context);
      if (!ok || !mounted) return;
    }
    try {
      final updated = await _repo.toggleLike(
        targetType: card.targetType,
        targetId: card.targetId,
      );
      if (mounted) _replaceCard(updated);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: KeptTheme.broke),
      );
    }
  }

  Future<void> _openComments(HomeCard card) async {
    final count = await showFeedCommentsSheet(
      context,
      targetType: card.targetType,
      targetId: card.targetId,
    );
    if (!mounted || count == null) return;
    final i = _feed.indexWhere(
      (c) => c.targetType == card.targetType && c.targetId == card.targetId,
    );
    if (i < 0) return;
    setState(() => _feed[i] = _feed[i].copyWith(commentCount: count));
  }

  void _openArticle(BlogPost post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BlogArticleScreen(slug: post.slug)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sidePad = width > KeptBreakpoints.contentMax
        ? (width - KeptBreakpoints.contentMax) / 2
        : 0.0;

    return ColoredBox(
      color: KeptTheme.void_,
      child: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: KeptTheme.accent,
          backgroundColor: KeptTheme.panel,
          onRefresh: refresh,
          child: _loading
              ? ListView(
                  children: const [
                    SizedBox(height: 180),
                    Center(
                      child: CircularProgressIndicator(color: KeptTheme.accent),
                    ),
                  ],
                )
              : _error != null
              ? ListView(
                  padding: EdgeInsets.fromLTRB(
                    24 + sidePad,
                    24,
                    24 + sidePad,
                    24,
                  ),
                  children: [
                    Text(
                      'Could not load the feed.\n$_error',
                      style: const TextStyle(color: KeptTheme.broke),
                    ),
                  ],
                )
              : CustomScrollView(
                  controller: _scroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: sidePad),
                      sliver: SliverToBoxAdapter(
                        child: _HomeGreeting(
                          name: _greetingName,
                          signedIn: client.auth.isAuthenticated,
                        ),
                      ),
                    ),
                    if (client.auth.isAuthenticated && _open.isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          18 + sidePad,
                          4,
                          18 + sidePad,
                          8,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _OpenVowsCard(
                            vows: _open,
                            checkingRoomId: _checkingRoom,
                            onCheckIn: _checkOpen,
                          ),
                        ),
                      ),
                    if (_feed.isEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          22 + sidePad,
                          28,
                          22 + sidePad,
                          40,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Your feed is quiet. Join a vow and check in — likes and comments live here too.',
                            style: GoogleFonts.manrope(
                              color: KeptTheme.mist,
                              height: 1.45,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: sidePad),
                        sliver: SliverList.builder(
                          itemCount: _feed.length + (_loadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= _feed.length) {
                              return const Padding(
                                padding: EdgeInsets.all(24),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: KeptTheme.accent,
                                  ),
                                ),
                              );
                            }
                            final card = _feed[index];
                            if (card.type == 'article' &&
                                card.article != null) {
                              return _ArticlePost(
                                card: card,
                                onOpen: () => _openArticle(card.article!),
                              );
                            }
                            if (card.activity != null) {
                              return _ActivityPost(
                                card: card,
                                onOpenRoom: () =>
                                    widget.onOpenRoom(card.activity!.roomId),
                                onLike: () => _toggleLike(card),
                                onComment: () => _openComments(card),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: widget.bottomPadding),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

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
    final countLabel = vows.length == 1
        ? '1 vow still open'
        : '${vows.length} vows still open';
    final border = BorderSide(
      color: KeptTheme.pending.withValues(alpha: 0.45),
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: border,
    );
    return Material(
      color: KeptTheme.panel,
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
          backgroundColor: KeptTheme.panel,
          collapsedBackgroundColor: KeptTheme.panel,
          shape: shape,
          collapsedShape: shape,
          title: Text(
            countLabel,
            style: GoogleFonts.sora(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              color: KeptTheme.paper,
            ),
          ),
          subtitle: Text(
            'Close the day from here.',
            style: GoogleFonts.manrope(fontSize: 13, color: KeptTheme.mist),
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
                const Divider(height: 20, color: KeptTheme.line),
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
    final percent = keptSharePercent(
      kept: vow.keptCount,
      broken: vow.brokenCount,
    );
    final verdict = percent == null ? 'No one has spoken' : '$percent% kept';
    final quiet = vow.pendingCount == 1
        ? '1 still quiet'
        : '${vow.pendingCount} still quiet';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vow.title,
          style: GoogleFonts.sora(
            fontWeight: FontWeight.w700,
            color: KeptTheme.paper,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          vow.rule,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(fontSize: 12, color: KeptTheme.mist),
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
                  foregroundColor: KeptTheme.void_,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'I kept it',
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
                  side: const BorderSide(color: KeptTheme.broke),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'I broke it',
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

class _HomeGreeting extends StatelessWidget {
  const _HomeGreeting({required this.name, required this.signedIn});

  final String? name;
  final bool signedIn;

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final hello = hour < 12
        ? 'Good morning'
        : hour < 18
        ? 'Good afternoon'
        : 'Good evening';
    final who = (name != null && name!.trim().isNotEmpty)
        ? name!.trim().split(' ').first
        : signedIn
        ? 'there'
        : null;
    final title = who == null ? 'Kept' : '$hello, $who';

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 10, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.sora(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: KeptTheme.paper,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  who == null
                      ? 'Public vows. Shared accountability.'
                      : 'What are you keeping today?',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: KeptTheme.mist,
                  ),
                ),
              ],
            ),
          ),
          KeptNativeIconButton(
            symbol: 'bell',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon.')),
              );
            },
            size: 40,
            style: CNButtonStyle.glass,
            tint: KeptTheme.paper,
            materialIcon: Icons.notifications_none_rounded,
            tooltip: 'Notifications',
          ),
        ],
      ),
    );
  }
}

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
                color: card.likedByMe ? KeptTheme.broke : KeptTheme.paper,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: onComment,
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: KeptTheme.paper,
                size: 24,
              ),
            ),
            if (trailing != null) ...[const Spacer(), trailing!],
          ],
        ),
        if (card.likeCount > 0) ...[
          const SizedBox(height: 8),
          Text(
            '${card.likeCount} like${card.likeCount == 1 ? '' : 's'}',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              color: KeptTheme.paper,
              fontSize: 13,
            ),
          ),
        ],
        if (card.commentCount > 0) ...[
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onComment,
            child: Text(
              'View all ${card.commentCount} comment'
              '${card.commentCount == 1 ? '' : 's'}',
              style: GoogleFonts.manrope(
                color: KeptTheme.mist,
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
    final item = card.activity!;
    final style = _PostVisual.ofActivity(item.kind);
    final mediaH = keptFeedMediaHeight(context, ratio: 0.92);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1, color: KeptTheme.line),
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
                        color: KeptTheme.paper,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item.roomTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: KeptTheme.mist,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _relativeTime(item.createdAt.toLocal()),
                style: GoogleFonts.manrope(fontSize: 12, color: KeptTheme.mist),
              ),
              IconButton(
                onPressed: onOpenRoom,
                icon: const Icon(Icons.more_horiz, color: KeptTheme.mist),
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
                colors: style.gradient,
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
                    color: Colors.white.withValues(alpha: 0.08),
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
                          color: Colors.black.withValues(alpha: 0.22),
                        ),
                        child: Icon(
                          style.icon,
                          size: 42,
                          color: KeptTheme.paper,
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
                            color: KeptTheme.paper,
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
                  label: CategoryStyle.of(item.roomCategory).label,
                  color: CategoryStyle.of(item.roomCategory).color,
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${item.displayName} ',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.paper,
                      ),
                    ),
                    TextSpan(
                      text: item.body,
                      style: GoogleFonts.manrope(
                        color: KeptTheme.paper.withValues(alpha: 0.92),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onOpenRoom,
                child: Text(
                  'Open room',
                  style: GoogleFonts.manrope(
                    color: KeptTheme.mist,
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
    final mediaH = keptFeedMediaHeight(context, ratio: 0.85);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1, color: KeptTheme.line),
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
                      'Kept Journal',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.paper,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      post.topic.toUpperCase(),
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        letterSpacing: 1.1,
                        color: KeptTheme.mist,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _relativeTime(post.publishedAt.toLocal()),
                style: GoogleFonts.manrope(fontSize: 12, color: KeptTheme.mist),
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
                colors: visual.gradient,
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
                KeptChip(label: 'Article', color: visual.color),
                const Spacer(),
                Text(
                  post.title,
                  style: GoogleFonts.sora(
                    fontSize: context.keptIsWide ? 28 : 30,
                    fontWeight: FontWeight.w700,
                    color: KeptTheme.paper,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  post.excerpt,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    height: 1.45,
                    color: KeptTheme.paper.withValues(alpha: 0.88),
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
                      text: 'Kept Journal ',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        color: KeptTheme.paper,
                      ),
                    ),
                    TextSpan(
                      text: post.excerpt,
                      style: GoogleFonts.manrope(
                        color: KeptTheme.paper.withValues(alpha: 0.9),
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
                  'Read article',
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
      case 'kept':
        return const _PostVisual(
          icon: Icons.check_rounded,
          color: KeptTheme.kept,
          gradient: [Color(0xFF1B3D2F), Color(0xFF0F1A14)],
          headline: 'Kept it',
        );
      case 'broke':
        return const _PostVisual(
          icon: Icons.close_rounded,
          color: KeptTheme.broke,
          gradient: [Color(0xFF3D1F1C), Color(0xFF140E0D)],
          headline: 'Broke it',
        );
      case 'joined':
        return const _PostVisual(
          icon: Icons.person_add_alt_1_rounded,
          color: KeptTheme.pending,
          gradient: [Color(0xFF3A3218), Color(0xFF14110A)],
          headline: 'Stepped in',
        );
      default:
        return const _PostVisual(
          icon: Icons.chat_bubble_rounded,
          color: KeptTheme.mist,
          gradient: [Color(0xFF1C2621), Color(0xFF0C100E)],
          headline: 'Said something',
        );
    }
  }

  static _PostVisual ofTopic(String topic) {
    switch (topic) {
      case 'water':
        return const _PostVisual(
          icon: Icons.water_drop_rounded,
          color: Color(0xFF5EEAD4),
          gradient: [Color(0xFF12353A), Color(0xFF0A1416)],
          headline: 'Water',
        );
      case 'focus':
        return const _PostVisual(
          icon: Icons.center_focus_strong_rounded,
          color: Color(0xFFFDE68A),
          gradient: [Color(0xFF3A3214), Color(0xFF12100A)],
          headline: 'Focus',
        );
      case 'move':
        return const _PostVisual(
          icon: Icons.directions_walk_rounded,
          color: Color(0xFF93C5FD),
          gradient: [Color(0xFF1A2A3D), Color(0xFF0C1218)],
          headline: 'Move',
        );
      default:
        return const _PostVisual(
          icon: Icons.auto_awesome_rounded,
          color: KeptTheme.accent,
          gradient: [Color(0xFF243528), Color(0xFF0E1411)],
          headline: 'Habits',
        );
    }
  }
}

String _relativeTime(DateTime t) {
  final diff = DateTime.now().difference(t);
  if (diff.inMinutes < 1) return 'now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m';
  if (diff.inHours < 24) return '${diff.inHours}h';
  if (diff.inDays < 7) return '${diff.inDays}d';
  return '${t.day}.${t.month}';
}
