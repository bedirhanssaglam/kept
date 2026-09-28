import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/init/dependency/dependency_items.dart';
import '../../../product/utility/state/base_view_model.dart';
import 'discover_state.dart';

final discoverViewModelProvider =
    AutoDisposeAsyncNotifierProvider<DiscoverViewModel, DiscoverState>(
      DiscoverViewModel.new,
    );

class DiscoverViewModel extends BaseViewModel<DiscoverState> {
  @override
  DiscoverState buildInitialState() => const DiscoverState.initial();

  @override
  Future<DiscoverState> build() async {
    final page = await ref
        .read(vowRepositoryProvider)
        .listPublicRooms(limit: 40, offset: 0);
    return DiscoverState(rooms: AsyncData(page));
  }

  Future<void> refresh() {
    return updateAsyncValue<VowRoomPage>(
      request: () =>
          ref.read(vowRepositoryProvider).listPublicRooms(limit: 40, offset: 0),
      onValue: (state, rooms) => state.copyWith(rooms: rooms),
    );
  }
}
