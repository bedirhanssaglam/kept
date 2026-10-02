import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../product/components/kept_native.dart';
import '../../../product/theme/kept_theme.dart';
import '../../../product/utility/layout/kept_breakpoints.dart';
import '../../auth/view/sign_in_sheet.dart';
import '../../create/view/create_vow_view.dart';
import '../../discover/view/discover_view.dart';
import '../../home/view/home_view.dart';
import '../../profile/view/profile_view.dart';
import '../../room/view/room_view.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../product/init/language/locale_keys.g.dart';

part 'widgets/navigation.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _homeKey = GlobalKey<HomeViewState>();
  final _discoverKey = GlobalKey<DiscoverViewState>();
  final _profileKey = GlobalKey<ProfileViewState>();

  Future<void> _openRoom(int roomId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RoomView(roomId: roomId)),
    );
    _homeKey.currentState?.refresh();
    _discoverKey.currentState?.refresh();
    _profileKey.currentState?.refresh();
  }

  Future<void> _openCreate() async {
    if (!client.auth.isAuthenticated) {
      final ok = await showSignInSheet(context);
      if (!ok || !mounted) return;
    }
    final created = await Navigator.of(context).push<VowRoom>(
      MaterialPageRoute(builder: (_) => const CreateVowView()),
    );
    if (created?.id == null || !mounted) return;
    setState(() => _index = 0);
    await _openRoom(created!.id!);
  }

  Widget _fab(BuildContext context) {
    if (keptUsesNativeCupertino) {
      return KeptNativeIconButton(
        symbol: 'plus',
        onPressed: _openCreate,
        size: 56,
        style: CNButtonStyle.prominentGlass,
        tint: KeptTheme.accent,
        materialIcon: Icons.add_rounded,
        tooltip: LocaleKeys.newVow.tr(),
      );
    }
    return FloatingActionButton(
      onPressed: _openCreate,
      backgroundColor: KeptTheme.accent,
      foregroundColor: context.kept.void_,
      elevation: 6,
      child: Icon(Icons.add_rounded, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Theme.of(context).brightness,
        primaryColor: KeptTheme.accent,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= KeptBreakpoints.compact;
          final bottomInset = MediaQuery.paddingOf(context).bottom;
          final ios = keptUsesNativeCupertino;
          final barReserve =
              wide ? 24.0 : (ios ? 92.0 : 72.0) + bottomInset;

          final pages = IndexedStack(
            index: _index,
            children: [
              HomeView(
                key: _homeKey,
                onOpenRoom: _openRoom,
                bottomPadding: barReserve + (wide ? 24 : 72),
              ),
              DiscoverView(
                key: _discoverKey,
                onOpenRoom: _openRoom,
                bottomPadding: barReserve,
              ),
              ProfileView(
                key: _profileKey,
                onOpenRoom: _openRoom,
              ),
            ],
          );

          if (wide) {
            final extended = constraints.maxWidth >= KeptBreakpoints.medium;
            return Scaffold(
              backgroundColor: context.kept.void_,
              body: Row(
                children: [
                  _KeptNavigationRail(
                    index: _index,
                    extended: extended,
                    onChanged: (i) => setState(() => _index = i),
                    onCreate: _openCreate,
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: context.kept.line.withValues(alpha: 0.8),
                  ),
                  Expanded(child: pages),
                ],
              ),
            );
          }

          if (ios) {
            return Scaffold(
              backgroundColor: context.kept.void_,
              body: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: barReserve,
                    child: Stack(
                      children: [
                        Positioned.fill(child: pages),
                        if (_index == 0)
                          Positioned(
                            right: 20,
                            bottom: 16,
                            child: _fab(context),
                          ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        10 + bottomInset * 0.35,
                      ),
                      child: KeptNativeTabBar(
                        height: 84,
                        tint: KeptTheme.accent,
                        currentIndex: _index,
                        onTap: (i) => setState(() => _index = i),
                        items: [
                          CNTabBarItem(
                            label: LocaleKeys.navHome.tr(),
                            icon: CNSymbol('house.fill'),
                          ),
                          CNTabBarItem(
                            label: LocaleKeys.navDiscover.tr(),
                            icon: CNSymbol('safari.fill'),
                          ),
                          CNTabBarItem(
                            label: LocaleKeys.navProfile.tr(),
                            icon: CNSymbol('person.crop.circle'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Scaffold(
            backgroundColor: context.kept.void_,
            extendBody: true,
            body: Stack(
              children: [
                Positioned.fill(child: pages),
                if (_index == 0)
                  Positioned(
                    right: 20,
                    bottom: barReserve + 8,
                    child: _fab(context),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    top: false,
                    child: _MaterialBottomBar(
                      index: _index,
                      onChanged: (i) => setState(() => _index = i),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
