import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../features/vows/domain/vow_labels.dart';
import '../../../product/brand/kept_brand.dart';
import '../../../product/components/async_data_widget.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/components/kept_widgets.dart';
import '../../../product/init/theme/appearance.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../auth/view/sign_in_sheet.dart';
import '../view_model/profile_state.dart';
import '../view_model/profile_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

part 'widgets/preferences.dart';
part 'widgets/profile_body.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key, required this.onOpenRoom});

  final ValueChanged<int> onOpenRoom;

  @override
  ConsumerState<ProfileView> createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  Future<void> refresh() {
    return ref.read(ProfileViewModel.provider.notifier).refresh();
  }

  Future<void> _signIn() async {
    await const SignInSheet().show(context);
  }

  Future<void> _signOut() async {
    await client.auth.signOutDevice();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.kept;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.wash, colors.void_],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: AsyncDataWidget<ProfileState>(
          asyncValue: ref.watch(ProfileViewModel.provider),
          onError: (error) => ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                LocaleKeys.couldNotLoadProfile.tr(
                  namedArgs: {'error': '$error'},
                ),
                style: TextStyle(color: KeptTheme.broke),
              ),
              const SizedBox(height: 16),
              KeptPrimaryButton(
                label: LocaleKeys.retry.tr(),
                onPressed: refresh,
              ),
            ],
          ),
          onData: (state) {
            final profile = state?.profile.valueOrNull;
            if (state == null || !state.signedIn || profile == null) {
              return _SignedOutBody(onSignIn: _signIn, bottomPadding: 24);
            }
            return RefreshIndicator(
              color: KeptTheme.accent,
              backgroundColor: context.kept.panel,
              onRefresh: refresh,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final sidePad =
                      constraints.maxWidth > KeptBreakpoints.contentMax
                      ? (constraints.maxWidth - KeptBreakpoints.contentMax) / 2
                      : 0.0;
                  return ListView(
                    padding: EdgeInsets.fromLTRB(
                      20 + sidePad,
                      18,
                      20 + sidePad,
                      110,
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.navProfile.tr(),
                              style: GoogleFonts.sora(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: context.kept.paper,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _signOut,
                            child: Text(
                              LocaleKeys.signOut.tr(),
                              style: GoogleFonts.manrope(
                                color: context.kept.mist,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _IdentityCard(profile: profile),
                      const SizedBox(height: 16),
                      const _PreferencesCard(),
                      const SizedBox(height: 28),
                      Text(
                        LocaleKeys.yourRooms.tr(),
                        style: GoogleFonts.sora(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: context.kept.paper,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        profile.rooms.isEmpty
                            ? LocaleKeys.roomsEmptyHint.tr()
                            : LocaleKeys.roomsTapHint.tr(),
                        style: GoogleFonts.manrope(
                          color: context.kept.mist,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 14),
                      if (profile.rooms.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: context.kept.panel,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: context.kept.line),
                          ),
                          child: Text(
                            LocaleKeys.noMemberships.tr(),
                            style: GoogleFonts.manrope(
                              color: context.kept.mist,
                            ),
                          ),
                        )
                      else
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: context.kept.panel,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: context.kept.line),
                          ),
                          child: Column(
                            children: [
                              for (
                                var i = 0;
                                i < profile.rooms.length;
                                i++
                              ) ...[
                                if (i > 0)
                                  Divider(
                                    height: 1,
                                    color: context.kept.line,
                                  ),
                                _ProfileRoomTile(
                                  room: profile.rooms[i],
                                  onTap: () => widget.onOpenRoom(
                                    profile.rooms[i].id!,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
