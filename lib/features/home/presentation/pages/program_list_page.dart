import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../stores/home_store.dart';
import 'home_page.dart';

class ProgramListPage extends StatefulWidget {
  const ProgramListPage({super.key});

  @override
  State<ProgramListPage> createState() => _ProgramListPageState();
}

class _ProgramListPageState extends State<ProgramListPage> {
  final HomeStore _store = GetIt.I<HomeStore>();

  @override
  void initState() {
    super.initState();
    _store.loadPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Cursos'),
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.errorMessage != null) {
            return Center(child: Text(_store.errorMessage!));
          }

          if (_store.programs.isEmpty) {
            return const Center(child: Text('Nenhum curso encontrado.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _store.programs.length,
            itemBuilder: (context, index) {
              final program = _store.programs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(
                    program.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${program.modules.length} módulos'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => HomePage(programId: program.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
