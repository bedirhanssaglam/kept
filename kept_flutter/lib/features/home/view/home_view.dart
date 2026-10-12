import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../features/vows/domain/vow_codes.dart';
import '../../../product/components/kept_widgets.dart';
import '../../../product/service/vow_repository.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/utility/activity_line.dart';
import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../auth/view/sign_in_sheet.dart';
import '../domain/home_card_kind.dart';
import '../view_model/home_view_model.dart';
import 'blog_article_view.dart';
import 'feed_comments_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

part 'widgets/greeting.dart';
part 'widgets/open_vows.dart';
part 'widgets/posts.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
    required this.onOpenRoom,
    this.bottomPadding = 24,
  });

  final ValueChanged<int> onOpenRoom;
  final double bottomPadding;

  @override
  ConsumerState<HomeView> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  final _scroll = ScrollController();

  HomeViewModel get _model => ref.read(HomeViewModel.provider.notifier);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final data = ref.read(HomeViewModel.provider).valueOrNull;
    if (data == null ||
        !data.hasMore ||
        data.loadingMore ||
        data.feed.isLoading) {
      return;
    }
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    if (pos.pixels > pos.maxScrollExtent - 420) {
      _model.loadMore();
    }
  }

  Future<void> refresh() => _model.refresh();

  Future<void> _checkOpen(OpenVow vow, bool kept) async {
    try {
      await _model.checkOpenVow(vow.roomId, kept);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error'), backgroundColor: KeptTheme.broke),
      );
    }
  }

  Future<void> _toggleLike(HomeCard card) async {
    if (!client.auth.isAuthenticated) {
      final ok = await const SignInSheet().show(context);
      if (!ok || !mounted) return;
    }
    try {
      final updated = await ref
          .read(VowRepository.provider)
          .toggleLike(
            targetType: card.targetType,
            targetId: card.targetId,
          );
      _model.replaceCard(updated);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error'), backgroundColor: KeptTheme.broke),
      );
    }
  }

  Future<void> _openComments(HomeCard card) async {
    final count = await FeedCommentsSheet(
      targetType: card.targetType,
      targetId: card.targetId,
    ).show(context);
    if (!mounted || count == null) return;
    _model.setCommentCount(
      targetType: card.targetType,
      targetId: card.targetId,
      count: count,
    );
  }

  void _openArticle(BlogPost post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BlogArticleView(slug: post.slug)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(HomeViewModel.provider);
    final data = home.valueOrNull;
    final feed = data?.feed.valueOrNull ?? const <HomeCard>[];
    final open = data?.openVows.valueOrNull ?? const <OpenVow>[];
    final greetingName = data?.greetingName;
    final loading = home.isLoading || (data?.feed.isLoading ?? false);
    final loadError = home.hasError
        ? '${home.error}'
        : (data?.feed.hasError ?? false)
        ? '${data!.feed.error}'
        : null;
    final loadingMore = data?.loadingMore ?? false;
    final width = MediaQuery.sizeOf(context).width;
    final sidePad = width > KeptBreakpoints.contentMax
        ? (width - KeptBreakpoints.contentMax) / 2
        : 0.0;

    return ColoredBox(
      color: context.kept.void_,
      child: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: KeptTheme.accent,
          backgroundColor: context.kept.panel,
          onRefresh: refresh,
          child: loading
              ? ListView(
                  children: const [
                    SizedBox(height: 180),
                    Center(
                      child: CircularProgressIndicator(color: KeptTheme.accent),
                    ),
                  ],
                )
              : loadError != null
              ? ListView(
                  padding: EdgeInsets.fromLTRB(
                    24 + sidePad,
                    24,
                    24 + sidePad,
                    24,
                  ),
                  children: [
                    Text(
                      LocaleKeys.feedLoadFailed.tr(
                        namedArgs: {'error': (loadError).toString()},
                      ),
                      style: TextStyle(color: KeptTheme.broke),
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
                          name: greetingName,
                          signedIn: client.auth.isAuthenticated,
                        ),
                      ),
                    ),
                    if (client.auth.isAuthenticated && open.isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          18 + sidePad,
                          4,
                          18 + sidePad,
                          8,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _OpenVowsCard(
                            vows: open,
                            checkingRoomId: data?.checkingRoomId,
                            onCheckIn: _checkOpen,
                          ),
                        ),
                      ),
                    if (feed.isEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          22 + sidePad,
                          28,
                          22 + sidePad,
                          40,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            LocaleKeys.feedQuiet.tr(),
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
                              height: 1.45,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: sidePad),
                        sliver: SliverList.builder(
                          itemCount: feed.length + (loadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= feed.length) {
                              return const Padding(
                                padding: EdgeInsets.all(24),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: KeptTheme.accent,
                                  ),
                                ),
                              );
                            }
                            final card = feed[index];
                            if (card.type == HomeCardKind.article &&
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
