import 'package:flutter/material.dart';
import 'package:pratica_musical/features/player/data/audio_service_impl.dart';
import 'package:pratica_musical/features/player/domain/audio_service_interface.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // For this smoke test, we instantiate directly.
  // In a real app, use GetIt/Injectable.
  final AudioService _audioService = AudioServiceImpl();
  int _bpm = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smoke Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BPM: $_bpm',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await _audioService.play();
                    result.fold(
                      (l) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(l.message))),
                      (r) => debugPrint('Play success'),
                    );
                  },
                  child: const Text('Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    final result = await _audioService.stop();
                    result.fold(
                      (l) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(l.message))),
                      (r) => debugPrint('Stop success'),
                    );
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _bpm += 10;
                });
                final result = await _audioService.setBpm(_bpm);
                result.fold(
                  (l) => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(l.message))),
                  (r) => debugPrint('BPM updated to $_bpm'),
                );
              },
              child: const Text('BPM +10'),
            ),
          ],
        ),
      ),
    );
  }
}
