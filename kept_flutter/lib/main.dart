import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'client.dart';
import 'core/theme/kept_theme.dart';
import 'features/onboarding/presentation/app_gate.dart';

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
  runApp(const KeptApp());
}

class KeptApp extends StatelessWidget {
  const KeptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kept',
      debugShowCheckedModeBanner: false,
      theme: KeptTheme.dark(),
      home: const AppGate(),
    );
  }
}
