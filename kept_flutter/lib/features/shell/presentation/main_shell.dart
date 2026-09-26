import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kept_client/kept_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../core/layout/kept_breakpoints.dart';
import '../../../core/theme/kept_theme.dart';
import '../../../core/widgets/kept_native.dart';
import '../../auth/presentation/sign_in_sheet.dart';
import '../../create/presentation/create_vow_screen.dart';
import '../../discover/presentation/discover_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../room/presentation/room_screen.dart';

/// Root shell: Home · Discover · Profile (+ create via home FAB).
/// Compact: bottom bar. Wide (≥600): navigation rail.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _homeKey = GlobalKey<HomeScreenState>();
  final _discoverKey = GlobalKey<DiscoverScreenState>();
  final _profileKey = GlobalKey<ProfileScreenState>();

  Future<void> _openRoom(int roomId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RoomScreen(roomId: roomId)),
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
      MaterialPageRoute(builder: (_) => const CreateVowScreen()),
    );
    if (created?.id == null || !mounted) return;
    setState(() => _index = 0);
    await _openRoom(created!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: KeptTheme.accent,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= KeptBreakpoints.compact;
          final bottomInset = MediaQuery.paddingOf(context).bottom;
          final barReserve = wide
              ? 24.0
              : (keptUsesNativeCupertino ? 70.0 : 72.0) + bottomInset;

          final pages = IndexedStack(
            index: _index,
            children: [
              HomeScreen(
                key: _homeKey,
                onOpenRoom: _openRoom,
                bottomPadding: barReserve + (wide ? 24 : 72),
              ),
              DiscoverScreen(
                key: _discoverKey,
                onOpenRoom: _openRoom,
                bottomPadding: barReserve,
              ),
              ProfileScreen(
                key: _profileKey,
                onOpenRoom: _openRoom,
              ),
            ],
          );

          if (wide) {
            final extended = constraints.maxWidth >= KeptBreakpoints.medium;
            return Scaffold(
              backgroundColor: KeptTheme.void_,
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
                    color: KeptTheme.line.withValues(alpha: 0.8),
                  ),
                  Expanded(child: pages),
                ],
              ),
            );
          }

          return Scaffold(
            backgroundColor: KeptTheme.void_,
            extendBody: true,
            body: Stack(
              children: [
                Positioned.fill(child: pages),
                if (_index == 0)
                  Positioned(
                    right: 20,
                    bottom: barReserve + 8,
                    child: keptUsesNativeCupertino
                        ? KeptNativeIconButton(
                            symbol: 'plus',
                            onPressed: _openCreate,
                            size: 56,
                            style: CNButtonStyle.prominentGlass,
                            tint: KeptTheme.accent,
                            materialIcon: Icons.add_rounded,
                            tooltip: 'New vow',
                          )
                        : FloatingActionButton(
                            onPressed: _openCreate,
                            backgroundColor: KeptTheme.accent,
                            foregroundColor: KeptTheme.void_,
                            elevation: 6,
                            child: const Icon(Icons.add_rounded, size: 30),
                          ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: keptUsesNativeCupertino
                      ? SafeArea(
                          top: false,
                          minimum: const EdgeInsets.only(bottom: 6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CNTabBar(
                              shrinkCentered: false,
                              tint: KeptTheme.accent,
                              currentIndex: _index,
                              onTap: (i) => setState(() => _index = i),
                              items: const [
                                CNTabBarItem(
                                  label: 'Home',
                                  icon: CNSymbol('house.fill'),
                                ),
                                CNTabBarItem(
                                  label: 'Discover',
                                  icon: CNSymbol('safari.fill'),
                                ),
                                CNTabBarItem(
                                  label: 'Profile',
                                  icon: CNSymbol('person.crop.circle'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _MaterialBottomBar(
                          index: _index,
                          onChanged: (i) => setState(() => _index = i),
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

class _KeptNavigationRail extends StatelessWidget {
  const _KeptNavigationRail({
    required this.index,
    required this.extended,
    required this.onChanged,
    required this.onCreate,
  });

  final int index;
  final bool extended;
  final ValueChanged<int> onChanged;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: KeptTheme.ink.withValues(alpha: 0.92),
      child: SafeArea(
        right: false,
        child: SizedBox(
          width: extended
              ? KeptBreakpoints.railExtendedWidth
              : KeptBreakpoints.railWidth,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: extended ? 18 : 8),
                child: extended
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Kept',
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: KeptTheme.paper,
                            letterSpacing: -0.5,
                          ),
                        ),
                      )
                    : Text(
                        'K',
                        style: GoogleFonts.sora(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: KeptTheme.accent,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: NavigationRail(
                  extended: extended,
                  backgroundColor: Colors.transparent,
                  selectedIndex: index,
                  onDestinationSelected: onChanged,
                  selectedIconTheme: const IconThemeData(
                    color: KeptTheme.accent,
                  ),
                  unselectedIconTheme: const IconThemeData(
                    color: KeptTheme.mist,
                  ),
                  selectedLabelTextStyle: GoogleFonts.manrope(
                    color: KeptTheme.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  unselectedLabelTextStyle: GoogleFonts.manrope(
                    color: KeptTheme.mist,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  indicatorColor: KeptTheme.accent.withValues(alpha: 0.14),
                  labelType: extended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  minWidth: KeptBreakpoints.railWidth,
                  minExtendedWidth: KeptBreakpoints.railExtendedWidth,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded),
                      label: Text('Discover'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: Text('Profile'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  extended ? 16 : 12,
                  8,
                  extended ? 16 : 12,
                  20,
                ),
                child: extended
                    ? SizedBox(
                        width: double.infinity,
                        child: keptUsesNativeCupertino
                            ? SizedBox(
                                height: 44,
                                width: double.infinity,
                                child: CNButton(
                                  label: 'New vow',
                                  onPressed: onCreate,
                                  tint: KeptTheme.accent,
                                  height: 44,
                                  style: CNButtonStyle.filled,
                                ),
                              )
                            : FilledButton.icon(
                                onPressed: onCreate,
                                style: FilledButton.styleFrom(
                                  backgroundColor: KeptTheme.accent,
                                  foregroundColor: KeptTheme.void_,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                icon: const Icon(Icons.add_rounded),
                                label: Text(
                                  'New vow',
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                      )
                    : keptUsesNativeCupertino
                    ? KeptNativeIconButton(
                        symbol: 'plus',
                        onPressed: onCreate,
                        size: 44,
                        style: CNButtonStyle.filled,
                        tint: KeptTheme.accent,
                        materialIcon: Icons.add_rounded,
                        tooltip: 'New vow',
                      )
                    : FloatingActionButton(
                        onPressed: onCreate,
                        mini: true,
                        backgroundColor: KeptTheme.accent,
                        foregroundColor: KeptTheme.void_,
                        child: const Icon(Icons.add_rounded),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MaterialBottomBar extends StatelessWidget {
  const _MaterialBottomBar({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Container(
        decoration: BoxDecoration(
          color: KeptTheme.ink.withValues(alpha: 0.94),
          border: const Border(top: BorderSide(color: KeptTheme.line)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8 + bottom),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                selected: index == 0,
                icon: Icons.home_rounded,
                label: 'Home',
                onTap: () => onChanged(0),
              ),
            ),
            Expanded(
              child: _NavItem(
                selected: index == 1,
                icon: Icons.explore_rounded,
                label: 'Discover',
                onTap: () => onChanged(1),
              ),
            ),
            Expanded(
              child: _NavItem(
                selected: index == 2,
                icon: Icons.person_rounded,
                label: 'Profile',
                onTap: () => onChanged(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? KeptTheme.accent : KeptTheme.mist;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? KeptTheme.accent.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: color,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
