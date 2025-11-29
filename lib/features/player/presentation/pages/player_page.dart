import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../../domain/exercise.dart';
import '../../domain/practice_phase.dart';
import '../stores/player_store.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final PlayerStore _playerStore = GetIt.I<PlayerStore>();
  late final ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    // Initialize with a dummy exercise for now
    _playerStore.initSession(const Exercise(
      name: 'Exercicio 1',
      targetBpm: 120,
      duration: Duration(seconds: 30), // Short duration for testing
    ));

    _disposer = reaction((_) => _playerStore.currentPhase, (phase) {
      if (phase == PracticePhase.finished) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Treino Concluído'),
            content: const Text('Parabéns! Você completou o exercício.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset or navigate back
                  _playerStore.initSession(const Exercise(
                    name: 'Exercicio 1',
                    targetBpm: 120,
                    duration: Duration(seconds: 30),
                  ));
                },
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prática Musical')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Phase Label
            Observer(
              builder: (_) => Text(
                _playerStore.phaseLabel,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            const SizedBox(height: 40),

            // BPM Display
            Observer(
              builder: (_) => Text(
                '${_playerStore.currentBpm} BPM',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 40),

            // Progress Bar
            Observer(
              builder: (_) => LinearProgressIndicator(
                value: _playerStore.progressPercentage,
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 10),
            Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(_playerStore.elapsedTime)),
                  Text(_formatDuration(_playerStore.targetDuration)),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () =>
                      _playerStore.setBpm(_playerStore.currentBpm - 5),
                ),
                const SizedBox(width: 20),
                Observer(
                  builder: (_) => FloatingActionButton.large(
                    onPressed: _playerStore.togglePlay,
                    child: Icon(_playerStore.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      _playerStore.setBpm(_playerStore.currentBpm + 5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
