part of '../main_shell.dart';

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
      color: context.kept.ink.withValues(alpha: 0.92),
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
                          context.l10n.appTitle,
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: context.kept.paper,
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
                  unselectedIconTheme: IconThemeData(
                    color: context.kept.mist,
                  ),
                  selectedLabelTextStyle: GoogleFonts.manrope(
                    color: KeptTheme.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  unselectedLabelTextStyle: GoogleFonts.manrope(
                    color: context.kept.mist,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  indicatorColor: KeptTheme.accent.withValues(alpha: 0.14),
                  labelType: extended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  minWidth: KeptBreakpoints.railWidth,
                  minExtendedWidth: KeptBreakpoints.railExtendedWidth,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text(context.l10n.navHome),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded),
                      label: Text(context.l10n.navDiscover),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: Text(context.l10n.navProfile),
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
                                  label: context.l10n.newVow,
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
                                  foregroundColor: context.kept.void_,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                icon: Icon(Icons.add_rounded),
                                label: Text(
                                  context.l10n.newVow,
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
                        tooltip: context.l10n.newVow,
                      )
                    : FloatingActionButton(
                        onPressed: onCreate,
                        mini: true,
                        backgroundColor: KeptTheme.accent,
                        foregroundColor: context.kept.void_,
                        child: Icon(Icons.add_rounded),
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
          color: context.kept.ink.withValues(alpha: 0.94),
          border: Border(top: BorderSide(color: context.kept.line)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8 + bottom),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                selected: index == 0,
                icon: Icons.home_rounded,
                label: context.l10n.navHome,
                onTap: () => onChanged(0),
              ),
            ),
            Expanded(
              child: _NavItem(
                selected: index == 1,
                icon: Icons.explore_rounded,
                label: context.l10n.navDiscover,
                onTap: () => onChanged(1),
              ),
            ),
            Expanded(
              child: _NavItem(
                selected: index == 2,
                icon: Icons.person_rounded,
                label: context.l10n.navProfile,
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
    final color = selected ? KeptTheme.accent : context.kept.mist;
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
