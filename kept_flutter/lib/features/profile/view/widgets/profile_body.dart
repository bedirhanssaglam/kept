part of '../profile_view.dart';

class _SignedOutBody extends StatelessWidget {
  const _SignedOutBody({
    required this.onSignIn,
    required this.bottomPadding,
  });

  final VoidCallback onSignIn;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 32, 24, bottomPadding + 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.navProfile.tr(),
            style: GoogleFonts.sora(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: context.kept.paper,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.shield_moon_rounded,
            size: 56,
            color: KeptTheme.accent,
          ),
          const SizedBox(height: 18),
          Text(
            LocaleKeys.ownYourWord.tr(),
            style: GoogleFonts.sora(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: context.kept.paper,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.signInProfileBody.tr(),
            style: GoogleFonts.manrope(
              color: context.kept.mist,
              height: 1.45,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 28),
          KeptPrimaryButton(
            label: LocaleKeys.signIn.tr(),
            onPressed: onSignIn,
          ),
          const SizedBox(height: 28),
          const _PreferencesCard(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.profile});

  final KeptProfile profile;

  @override
  Widget build(BuildContext context) {
    final initial = profile.displayName.isNotEmpty
        ? profile.displayName.substring(0, 1).toUpperCase()
        : '?';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KeptTheme.accent.withValues(alpha: 0.16),
            context.kept.panel,
          ],
        ),
        border: Border.all(color: context.kept.line),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.kept.ink,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: KeptTheme.accent.withValues(alpha: 0.45),
                  ),
                ),
                child: Text(
                  initial,
                  style: GoogleFonts.sora(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: KeptTheme.accent,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName,
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      LocaleKeys.activeVows.plural(profile.memberRoomCount),
                      style: GoogleFonts.manrope(
                        color: context.kept.mist,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(height: 1, color: context.kept.line),
          const SizedBox(height: 12),
          _TodayStats(profile: profile),
        ],
      ),
    );
  }
}

Widget _statDivider(BuildContext context) {
  return Container(width: 1, height: 36, color: context.kept.line);
}

class _TodayStats extends StatelessWidget {
  const _TodayStats({required this.profile});

  final KeptProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            label: LocaleKeys.statKept.tr(),
            value: '${profile.keptToday}',
            color: KeptTheme.kept,
          ),
        ),
        _statDivider(context),
        Expanded(
          child: _StatTile(
            label: LocaleKeys.statBroke.tr(),
            value: '${profile.brokeToday}',
            color: KeptTheme.broke,
          ),
        ),
        _statDivider(context),
        Expanded(
          child: _StatTile(
            label: LocaleKeys.statOpen.tr(),
            value: '${profile.pendingToday}',
            color: KeptTheme.pending,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.sora(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: context.kept.mist,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ProfileRoomTile extends StatelessWidget {
  const _ProfileRoomTile({required this.room, required this.onTap});

  final VowRoom room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cat = CategoryStyle.of(context, room.category);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KeptChip(label: cat.label, color: cat.color),
                    const SizedBox(height: 10),
                    Text(
                      room.title,
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.kept.paper,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vowSpanLine(durationDays: room.durationDays,
                        startsOn: room.startsOn,
                      ),
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: context.kept.mist,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: context.kept.mist),
            ],
          ),
        ),
      ),
    );
  }
}
