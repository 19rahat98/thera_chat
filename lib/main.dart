import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theta_chat/common/constants/app_global_constants.dart';
import 'package:theta_chat/feature/launch/presentation/ui/launch_screen.dart';
import 'package:theta_chat/di/service_locator.dart' as di_locator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di_locator.initLocator();

  /// установка ориентации
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: AppGlobalConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const LaunchScreen(),
    );
  }
}
