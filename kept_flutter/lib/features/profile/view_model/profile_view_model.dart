import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/service/vow_repository.dart';
import '../../../product/utility/state/base_view_model.dart';
import 'profile_state.dart';

class ProfileViewModel extends BaseViewModel<ProfileState> {
  static final provider =
      AutoDisposeAsyncNotifierProvider<ProfileViewModel, ProfileState>(
        ProfileViewModel.new,
      );
  @override
  ProfileState buildInitialState() => const ProfileState.initial();

  @override
  Future<ProfileState> build() async {
    void onAuth() {
      refresh();
    }

    client.auth.authInfoListenable.addListener(onAuth);
    ref.onDispose(() => client.auth.authInfoListenable.removeListener(onAuth));
    return _load();
  }

  Future<void> refresh() {
    return updateAsyncValue<KeptProfile?>(
      request: _fetch,
      onValue: (state, profile) => state.copyWith(
        profile: profile,
        signedIn: client.auth.isAuthenticated,
      ),
    );
  }

  Future<ProfileState> _load() async {
    final profile = await _fetch();
    return ProfileState(
      profile: AsyncData(profile),
      signedIn: client.auth.isAuthenticated,
    );
  }

  Future<KeptProfile?> _fetch() async {
    if (!client.auth.isAuthenticated) return null;
    return ref.read(VowRepository.provider).getMyProfile();
  }
}
