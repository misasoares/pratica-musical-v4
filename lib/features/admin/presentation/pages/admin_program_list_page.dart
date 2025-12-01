import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../stores/admin_store.dart';
import 'admin_program_edit_page.dart';

class AdminProgramListPage extends StatefulWidget {
  const AdminProgramListPage({super.key});

  @override
  State<AdminProgramListPage> createState() => _AdminProgramListPageState();
}

class _AdminProgramListPageState extends State<AdminProgramListPage> {
  final AdminStore _store = GetIt.I<AdminStore>();

  @override
  void initState() {
    super.initState();
    _store.loadPrograms();
  }

  void _navigateToEdit([String? programId]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminProgramEditPage(programId: programId),
      ),
    );
    _store.loadPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Programas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEdit(),
        child: const Icon(Icons.add),
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Erro: ${_store.errorMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _store.loadPrograms,
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          if (_store.programs.isEmpty) {
            return const Center(child: Text('Nenhum programa encontrado.'));
          }

          return ListView.builder(
            itemCount: _store.programs.length,
            itemBuilder: (context, index) {
              final program = _store.programs[index];
              return ListTile(
                leading: program.thumbnailUrl.isNotEmpty
                    ? Image.network(
                        program.thumbnailUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      )
                    : const Icon(Icons.image),
                title: Text(program.title),
                subtitle: Text(
                    'Ordem: ${program.order} | Visível: ${program.isVisible ? "Sim" : "Não"}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _navigateToEdit(program.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Excluir Programa?'),
                            content: const Text(
                                'Tem certeza que deseja excluir este programa?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Excluir',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          await _store.deleteProgram(program.id);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
