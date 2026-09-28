import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

class DiscoverState {
  const DiscoverState({required this.rooms});

  const DiscoverState.initial() : rooms = const AsyncLoading();

  final AsyncValue<VowRoomPage> rooms;

  DiscoverState copyWith({AsyncValue<VowRoomPage>? rooms}) {
    return DiscoverState(rooms: rooms ?? this.rooms);
  }
}
