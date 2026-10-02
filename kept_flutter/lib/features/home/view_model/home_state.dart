import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

class HomeState {
  const HomeState({
    required this.feed,
    required this.openVows,
    required this.greetingName,
    required this.hasMore,
    required this.loadingMore,
    this.checkingRoomId,
  });

  const HomeState.initial()
    : feed = const AsyncLoading(),
      openVows = const AsyncLoading(),
      greetingName = null,
      hasMore = false,
      loadingMore = false,
      checkingRoomId = null;

  final AsyncValue<List<HomeCard>> feed;
  final AsyncValue<List<OpenVow>> openVows;
  final String? greetingName;
  final bool hasMore;
  final bool loadingMore;
  final int? checkingRoomId;

  HomeState copyWith({
    AsyncValue<List<HomeCard>>? feed,
    AsyncValue<List<OpenVow>>? openVows,
    String? greetingName,
    bool? hasMore,
    bool? loadingMore,
    int? checkingRoomId,
    bool clearGreeting = false,
    bool clearChecking = false,
  }) {
    return HomeState(
      feed: feed ?? this.feed,
      openVows: openVows ?? this.openVows,
      greetingName: clearGreeting ? null : greetingName ?? this.greetingName,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      checkingRoomId: clearChecking
          ? null
          : checkingRoomId ?? this.checkingRoomId,
    );
  }
}
