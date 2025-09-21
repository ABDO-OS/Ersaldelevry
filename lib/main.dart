import 'package:flutter/material.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routing/app_router.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
