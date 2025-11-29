import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../../content/domain/entities/exercise.dart';
import '../../domain/practice_phase.dart';
import '../stores/player_store.dart';
import '../args/player_page_args.dart';
import '../../../content/domain/repositories/i_content_repository.dart';

class PlayerPage extends StatefulWidget {
  final PlayerPageArgs? args;

  const PlayerPage({super.key, this.args});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final PlayerStore _store = GetIt.I<PlayerStore>();
  final List<ReactionDisposer> _disposers = [];

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeSession();
    _setupReactions();
  }

  Future<void> _initializeSession() async {
    if (widget.args != null) {
      await _store.initSession(widget.args!.exercise);
      if (mounted) {
        await _initializeVideo(widget.args!.exercise.videoUrl);
      }
    } else {
      await _store.initSession(const Exercise(
        id: 'dummy_1',
        title: 'Exercicio 1',
        videoUrl: 'assets/videos/ex01.mp4',
        tabUrl: 'assets/images/tabs/ex01.png',
        startBpmCalibration: 120,
      ));
    }
  }

  Future<void> _initializeVideo(String videoUrl) async {
    // For now, we assume assets. In real app, check if http/https
    if (videoUrl.startsWith('http')) {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    } else {
      _videoPlayerController = VideoPlayerController.asset(videoUrl);
    }

    try {
      await _videoPlayerController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: true,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        placeholder: const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Erro ao carregar vídeo: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  void _setupReactions() {
    _disposers.add(reaction((_) => _store.currentPhase, (phase) {
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
                  _store.initSession(const Exercise(
                    id: 'dummy_1',
                    title: 'Exercicio 1',
                    videoUrl: 'assets/videos/ex01.mp4',
                    tabUrl: 'assets/images/tabs/ex01.png',
                    startBpmCalibration: 120,
                  ));
                },
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        );
      }
    }));
  }

  @override
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _navigateToNextExercise() async {
    if (widget.args == null || widget.args!.currentSchedule == null) return;

    final nextIndex = widget.args!.exerciseIndex + 1;
    final nextExerciseId = widget.args!.currentSchedule!.exercises[nextIndex];

    final repo = GetIt.I<IContentRepository>();
    final nextExercise = await repo.getExercise(nextExerciseId);

    if (nextExercise != null && mounted) {
      if (_store.isPlaying) {
        await _store.togglePlay();
      }

      if (mounted) {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => PlayerPage(
              args: PlayerPageArgs(
                exercise: nextExercise,
                currentSchedule: widget.args!.currentSchedule,
                exerciseIndex: nextIndex,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args?.exercise.title ?? 'Prática Musical'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Video Player
              if (_chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized)
                AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: Chewie(controller: _chewieController!),
                )
              else
                Container(
                  height: 200,
                  color: Colors.black12,
                  child: const Center(child: Icon(Icons.movie, size: 50)),
                ),

              const SizedBox(height: 24),

              // Phase Label
              Observer(
                builder: (_) => Text(
                  _store.phaseLabel,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
              const SizedBox(height: 20),

              // BPM Display
              Observer(
                builder: (_) => Text(
                  '${_store.currentBpm} BPM',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 20),

              // Progress Bar
              Observer(
                builder: (_) => LinearProgressIndicator(
                  value: _store.progressPercentage,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 10),
              Observer(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_store.elapsedTime)),
                    Text(_formatDuration(_store.targetDuration)),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => _store.setBpm(_store.currentBpm - 5),
                  ),
                  const SizedBox(width: 20),
                  // Play/Pause Button
                  Observer(
                    builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 64,
                          icon: Icon(_store.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled),
                          onPressed: _store.togglePlay,
                        ),
                        if (widget.args?.currentSchedule != null &&
                            widget.args!.exerciseIndex <
                                widget.args!.currentSchedule!.exercises.length -
                                    1) ...[
                          const SizedBox(width: 16),
                          IconButton(
                            iconSize: 48,
                            icon: const Icon(Icons.skip_next),
                            onPressed: () => _navigateToNextExercise(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _store.setBpm(_store.currentBpm + 5),
                  ),
                ],
              ),
            ],
          ),
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
