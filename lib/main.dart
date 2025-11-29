import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/player/presentation/player_screen.dart';

void main() {
  runApp(const GuitarMasterApp());
}

class GuitarMasterApp extends StatelessWidget {
  const GuitarMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prática Musical',
      theme: AppTheme.darkTheme,
      home: const PlayerScreen(),
    );
  }
}
