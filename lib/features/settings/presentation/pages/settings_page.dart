import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/theme/theme_store.dart';
import '../stores/settings_store.dart';

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
          const Divider(),
          const ListTile(
            title: Text('Sobre'),
            subtitle: Text('Versão 1.0.0 (MVP Beta)'),
            leading: Icon(Icons.info_outline),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Apagar Tudo?'),
                    content: const Text(
                        'Isso apagará todo seu histórico de treinos e resetará o app para o estado inicial. Essa ação não pode ser desfeita.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Apagar',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final settingsStore = GetIt.I<SettingsStore>();
                  await settingsStore.resetProgress();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Progresso resetado com sucesso! Reinicie o app.')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text('Resetar Progresso (Debug)'),
            ),
          ),
        ],
      ),
    );
  }
}
