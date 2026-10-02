import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'client.dart';
import 'features/onboarding/view/app_gate.dart';
import 'product/init/language/locale_enums.dart';
import 'product/init/theme/appearance.dart';
import 'product/navigation/room_links.dart';
import 'product/theme/kept_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
  await initializeClient();
  await EasyLocalization.ensureInitialized();
  await loadAppearancePrefs();
  runApp(
    EasyLocalization(
      supportedLocales: LocaleEnums.supported,
      path: 'assets/translations',
      fallbackLocale: LocaleEnums.en.locale,
      useOnlyLangCode: true,
      child: const ProviderScope(
        child: RoomLinkHost(child: KeptApp()),
      ),
    ),
  );
}

class KeptApp extends ConsumerWidget {
  const KeptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appearanceProvider);
    final lightIcons = mode == ThemeMode.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: lightIcons
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: lightIcons
            ? Brightness.light
            : Brightness.dark,
      ),
    );
    return MaterialApp(
      onGenerateTitle: (context) => 'appTitle'.tr(),
      debugShowCheckedModeBanner: false,
      theme: KeptTheme.light(),
      darkTheme: KeptTheme.dark(),
      themeMode: mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const AppGate(),
    );
  }
}
