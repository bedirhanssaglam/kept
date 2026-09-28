import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';

class ProfileState {
  const ProfileState({required this.profile, required this.signedIn});

  const ProfileState.initial()
    : profile = const AsyncLoading(),
      signedIn = false;

  final AsyncValue<KeptProfile?> profile;
  final bool signedIn;

  ProfileState copyWith({
    AsyncValue<KeptProfile?>? profile,
    bool? signedIn,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      signedIn: signedIn ?? this.signedIn,
    );
  }
}
