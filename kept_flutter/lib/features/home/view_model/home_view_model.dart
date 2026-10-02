import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/init/dependency/dependency_items.dart';
import '../../../product/utility/state/base_view_model.dart';
import 'home_state.dart';

final homeViewModelProvider =
    AutoDisposeAsyncNotifierProvider<HomeViewModel, HomeState>(
      HomeViewModel.new,
    );

class HomeViewModel extends BaseViewModel<HomeState> {
  @override
  HomeState buildInitialState() => const HomeState.initial();

  @override
  Future<HomeState> build() async {
    void onAuth() {
      refresh();
    }

    client.auth.authInfoListenable.addListener(onAuth);
    ref.onDispose(() => client.auth.authInfoListenable.removeListener(onAuth));
    return _load();
  }

  Future<void> refresh() async {
    final current = state.valueOrNull ?? buildInitialState();
    state = AsyncData(current.copyWith(feed: const AsyncLoading()));
    try {
      state = AsyncData(await _load());
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.loadingMore || !current.hasMore) return;
    final existing = current.feed.valueOrNull ?? const <HomeCard>[];
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final page = await ref
          .read(vowRepositoryProvider)
          .listHomeFeed(limit: 15, offset: existing.length);
      state = AsyncData(
        current.copyWith(
          feed: AsyncData([...existing, ...page.items]),
          hasMore: page.hasMore,
          loadingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(loadingMore: false));
    }
  }

  Future<void> checkOpenVow(int roomId, bool kept) async {
    final current = state.valueOrNull;
    if (current == null || current.checkingRoomId != null) return;
    state = AsyncData(current.copyWith(checkingRoomId: roomId));
    try {
      await ref.read(vowRepositoryProvider).checkIn(roomId: roomId, kept: kept);
      final open = await ref.read(vowRepositoryProvider).listOpenVows();
      final latest = state.valueOrNull ?? current;
      state = AsyncData(
        latest.copyWith(openVows: AsyncData(open), clearChecking: true),
      );
    } catch (_) {
      final latest = state.valueOrNull ?? current;
      state = AsyncData(latest.copyWith(clearChecking: true));
      rethrow;
    }
  }

  void replaceCard(HomeCard updated) {
    final current = state.valueOrNull;
    final feed = current?.feed.valueOrNull;
    if (current == null || feed == null) return;
    final next = [
      for (final card in feed)
        card.targetType == updated.targetType &&
                card.targetId == updated.targetId
            ? updated
            : card,
    ];
    state = AsyncData(current.copyWith(feed: AsyncData(next)));
  }

  void setCommentCount({
    required String targetType,
    required int targetId,
    required int count,
  }) {
    final current = state.valueOrNull;
    final feed = current?.feed.valueOrNull;
    if (current == null || feed == null) return;
    final next = [
      for (final card in feed)
        card.targetType == targetType && card.targetId == targetId
            ? card.copyWith(commentCount: count)
            : card,
    ];
    state = AsyncData(current.copyWith(feed: AsyncData(next)));
  }

  Future<HomeState> _load() async {
    final repo = ref.read(vowRepositoryProvider);
    final feedFuture = repo.listHomeFeed(limit: 15, offset: 0);
    if (!client.auth.isAuthenticated) {
      final feed = await feedFuture;
      return HomeState(
        feed: AsyncData(feed.items),
        openVows: const AsyncData([]),
        greetingName: null,
        hasMore: feed.hasMore,
        loadingMore: false,
        checkingRoomId: null,
      );
    }
    final results = await Future.wait([
      feedFuture,
      repo.getMyProfile(),
      repo.listOpenVows(),
    ]);
    final feed = results[0] as HomeFeedPage;
    final profile = results[1] as KeptProfile;
    final open = results[2] as List<OpenVow>;
    return HomeState(
      feed: AsyncData(feed.items),
      openVows: AsyncData(open),
      greetingName: profile.displayName,
      hasMore: feed.hasMore,
      loadingMore: false,
      checkingRoomId: null,
    );
  }
}
