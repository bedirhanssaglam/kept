part of '../profile_view.dart';

class _PreferencesCard extends ConsumerWidget {
  const _PreferencesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colors = context.kept;
    final light = ref.watch(appearanceProvider) == ThemeMode.light;
    final language = context.locale.languageCode;
    final languageLabel = language == 'tr'
        ? l10n.languageTurkish
        : l10n.languageEnglish;

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
          title: Text(l10n.language, style: TextStyle(color: tileColor)),
          trailing: keptUsesNativeCupertino
              ? CNPopupMenuButton(
                  buttonLabel: languageLabel,
                  tint: KeptTheme.accent,
                  height: 32,
                  items: [
                    CNPopupMenuItem(label: l10n.languageEnglish),
                    CNPopupMenuItem(label: l10n.languageTurkish),
                  ],
                  onSelected: (index) {
                    final locale = index == 1
                        ? LocaleEnums.tr.locale
                        : LocaleEnums.en.locale;
                    context.setLocale(locale);
                  },
                )
              : DropdownButton<String>(
                  value: language == 'tr' ? 'tr' : 'en',
                  underline: const SizedBox.shrink(),
                  dropdownColor: colors.panel,
                  style: TextStyle(color: tileColor),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(l10n.languageEnglish),
                    ),
                    DropdownMenuItem(
                      value: 'tr',
                      child: Text(l10n.languageTurkish),
                    ),
                  ],
                  onChanged: (code) {
                    if (code == null) return;
                    context.setLocale(
                      code == 'tr'
                          ? LocaleEnums.tr.locale
                          : LocaleEnums.en.locale,
                    );
                  },
                ),
        ),
        CupertinoListTile(
          backgroundColor: bg,
          title: Text(l10n.appearance, style: TextStyle(color: tileColor)),
          additionalInfo: Text(
            light ? l10n.themeLight : l10n.themeDark,
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
          title: Text(l10n.about, style: TextStyle(color: tileColor)),
          trailing: Icon(
            CupertinoIcons.chevron_forward,
            color: colors.mist,
            size: 18,
          ),
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute<void>(builder: (_) => const _AboutPage()),
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
    final l10n = context.l10n;
    final colors = context.kept;
    return CupertinoPageScaffold(
      backgroundColor: colors.void_,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: colors.ink,
        middle: Text(l10n.about, style: TextStyle(color: colors.paper)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          children: [
            Text(
              l10n.appTitle,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: colors.paper,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.aboutBody,
              style: TextStyle(fontSize: 16, height: 1.4, color: colors.mist),
            ),
            const SizedBox(height: 24),
            CupertinoListSection.insetGrouped(
              margin: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              decoration: BoxDecoration(
                color: colors.panel,
                borderRadius: BorderRadius.circular(12),
              ),
              children: [
                CupertinoListTile(
                  backgroundColor: colors.panel,
                  title: Text(
                    l10n.versionLabel,
                    style: TextStyle(color: colors.paper),
                  ),
                  additionalInfo: Text(
                    '1.0.0',
                    style: TextStyle(color: colors.mist),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
