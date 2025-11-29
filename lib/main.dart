import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/player/data/models/practice_log_model.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PracticeLogModelAdapter());
  setupServiceLocator();
  runApp(const GuitarMasterApp());
}

class GuitarMasterApp extends StatelessWidget {
  const GuitarMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prática Musical',
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
