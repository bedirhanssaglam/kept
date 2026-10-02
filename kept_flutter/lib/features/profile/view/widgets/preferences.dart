part of '../profile_view.dart';

class _PreferencesCard extends ConsumerWidget {
  const _PreferencesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.kept;
    final light = ref.watch(appearanceProvider) == ThemeMode.light;

    final tileColor = colors.paper;
    final bg = colors.panel;

    return CupertinoListSection.insetGrouped(
      margin: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      dividerMargin: 16,
      children: [
        CupertinoListTile(
          backgroundColor: bg,
          title: Text(LocaleKeys.appearance.tr(), style: TextStyle(color: tileColor)),
          additionalInfo: Text(
            light ? LocaleKeys.themeLight.tr() : LocaleKeys.themeDark.tr(),
            style: TextStyle(color: colors.mist),
          ),
          trailing: keptUsesNativeCupertino
              ? CNSwitch(
                  value: light,
                  color: KeptTheme.accent,
                  onChanged: (on) => ref
                      .read(appearanceProvider.notifier)
                      .use(on ? ThemeMode.light : ThemeMode.dark),
                )
              : CupertinoSwitch(
                  value: light,
                  activeTrackColor: KeptTheme.accent,
                  onChanged: (on) => ref
                      .read(appearanceProvider.notifier)
                      .use(on ? ThemeMode.light : ThemeMode.dark),
                ),
        ),
        CupertinoListTile(
          backgroundColor: bg,
          title: Text(LocaleKeys.about.tr(), style: TextStyle(color: tileColor)),
          trailing: Icon(
            CupertinoIcons.chevron_forward,
            color: colors.mist,
            size: 18,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const _AboutPage()),
            );
          },
        ),
      ],
    );
  }
}

class _AboutPage extends StatelessWidget {
  const _AboutPage();

  @override
  Widget build(BuildContext context) {
    final colors = context.kept;
    return Scaffold(
      backgroundColor: colors.void_,
      appBar: AppBar(
        backgroundColor: colors.void_,
        foregroundColor: colors.paper,
        elevation: 0,
        title: Text(
          LocaleKeys.about.tr(),
          style: GoogleFonts.sora(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: colors.paper,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            width: 72,
            height: 72,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.appTitle.tr(),
            style: GoogleFonts.sora(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: colors.paper,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.aboutBody.tr(),
            style: GoogleFonts.manrope(
              fontSize: 16,
              height: 1.4,
              color: colors.mist,
            ),
          ),
          const SizedBox(height: 24),
          Material(
            color: colors.panel,
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              title: Text(
                LocaleKeys.versionLabel.tr(),
                style: TextStyle(color: colors.paper),
              ),
              trailing: Text(
                '1.0.0',
                style: TextStyle(color: colors.mist),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
