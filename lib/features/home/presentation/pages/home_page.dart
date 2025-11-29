import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/app_settings_service.dart';
import '../../../onboarding/presentation/dialogs/practice_onboarding_dialog.dart';
import '../../../player/presentation/pages/player_page.dart';
import '../../../player/presentation/args/player_page_args.dart';
import '../../../content/domain/repositories/i_content_repository.dart';
import '../stores/home_store.dart';
import '../../../content/domain/entities/module.dart';
import '../../../content/domain/entities/schedule.dart';
import '../../../content/domain/entities/theory_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _store = GetIt.I<HomeStore>();

  @override
  void initState() {
    super.initState();
    _store.loadProgram();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) => Text(_store.program?.title ?? 'Carregando...'),
        ),
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.errorMessage != null) {
            return Center(child: Text(_store.errorMessage!));
          }

          if (_store.program == null) {
            return const Center(child: Text('Nenhum curso encontrado.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _store.program!.modules.length,
            itemBuilder: (context, index) {
              final module = _store.program!.modules[index];
              return _buildModuleCard(module);
            },
          );
        },
      ),
    );
  }

  Widget _buildModuleCard(Module module) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          module.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(module.type == 'theory' ? 'Teoria' : 'Prática'),
        children: [
          if (module.contents != null)
            ...module.contents!.map((content) => _buildTheoryItem(content)),
          if (module.schedules != null)
            ...module.schedules!
                .map((schedule) => _buildScheduleItem(schedule)),
        ],
      ),
    );
  }

  Widget _buildTheoryItem(TheoryContent content) {
    return ListTile(
      leading: const Icon(Icons.play_circle_outline),
      title: Text(content.title),
      onTap: () {
        // TODO: Navigate to video player
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Abrir aula: ${content.title}')),
        );
      },
    );
  }

  Widget _buildScheduleItem(Schedule schedule) {
    return ListTile(
      leading: const Icon(Icons.fitness_center),
      title: Text(schedule.title),
      subtitle: Text(schedule.description),
      onTap: () async {
        final settings = GetIt.I<AppSettingsService>();
        final hasSeen = await settings.hasSeenPracticeOnboarding();

        if (!mounted) return;

        if (!hasSeen) {
          await showDialog(
            context: context,
            builder: (_) => const PracticeOnboardingDialog(),
          );
          await settings.setSeenPracticeOnboarding();
        }

        if (!mounted) return;

        // Start with the first exercise
        if (schedule.exercises.isNotEmpty) {
          final exerciseId = schedule.exercises.first;
          // In a real app, we would fetch the full exercise object here or pass the ID
          // For now, we need to fetch it from the repository to pass to PlayerPage
          final repo = GetIt.I<IContentRepository>();
          final exercise = await repo.getExercise(exerciseId);

          if (exercise != null && mounted) {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlayerPage(
                  args: PlayerPageArgs(
                    exercise: exercise,
                    currentSchedule: schedule,
                    exerciseIndex: 0,
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
