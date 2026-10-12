import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

import '../../../product/service/vow_repository.dart';
import '../../../product/utility/state/base_view_model.dart';
import 'discover_state.dart';

class DiscoverViewModel extends BaseViewModel<DiscoverState> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<DiscoverViewModel, DiscoverState>(
        DiscoverViewModel.new,
      );
  @override
  DiscoverState buildInitialState() => const DiscoverState.initial();

  @override
  Future<DiscoverState> build() async {
    final page = await ref
        .read(VowRepository.provider)
        .listPublicRooms(limit: 40, offset: 0);
    return DiscoverState(rooms: AsyncData(page));
  }

  Future<void> refresh() {
    return updateAsyncValue<VowRoomPage>(
      request: () => ref
          .read(VowRepository.provider)
          .listPublicRooms(limit: 40, offset: 0),
      onValue: (state, rooms) => state.copyWith(rooms: rooms),
    );
  }
}
