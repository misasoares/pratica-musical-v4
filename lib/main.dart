import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/service_locator.dart';
import 'features/player/data/models/practice_log_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_store.dart';
import 'features/home/presentation/pages/main_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PracticeLogModelAdapter());
  setupServiceLocator();

  // Load saved theme
  final themeStore = GetIt.I<ThemeStore>();
  await themeStore.loadTheme();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = GetIt.I<ThemeStore>();

    return Observer(
      builder: (_) {
        return MaterialApp(
          title: 'Prática Musical',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const MainScreen(),
        );
      },
    );
  }
}
