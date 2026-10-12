import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'client.dart';
import 'features/onboarding/view/app_gate.dart';
import 'product/init/language/app_language.dart';
import 'product/init/language/codegen_loader.g.dart';
import 'product/init/language/locale_keys.g.dart';
import 'product/init/theme/appearance.dart';
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
  final appearance = await AppearanceStore.load();
  runApp(
    EasyLocalization(
      supportedLocales: AppLanguage.locales,
      path: AppLanguage.translationsPath,
      fallbackLocale: AppLanguage.fallback.locale,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: ProviderScope(
        overrides: [
          AppearanceStore.provider.overrideWithValue(appearance),
        ],
        child: const KeptApp(),
      ),
    ),
  );
}

class KeptApp extends ConsumerWidget {
  const KeptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(AppearanceNotifier.provider);
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
      onGenerateTitle: (_) => LocaleKeys.appTitle.tr(),
      debugShowCheckedModeBanner: false,
      theme: KeptTheme.light(),
      darkTheme: KeptTheme.dark(),
      themeMode: mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
      home: const AppGate(),
    );
  }
}
