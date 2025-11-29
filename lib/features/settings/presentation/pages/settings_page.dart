import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/theme/theme_store.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = GetIt.I<ThemeStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          Observer(
            builder: (_) => SwitchListTile(
              title: const Text('Modo Escuro'),
              subtitle: const Text('Alternar entre tema claro e escuro'),
              value: themeStore.isDarkMode,
              onChanged: (value) {
                themeStore.toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
