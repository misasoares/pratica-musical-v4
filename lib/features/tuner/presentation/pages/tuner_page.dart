import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'dart:math' as math;
import '../../../../core/services/permission_service.dart';
import '../stores/tuner_store.dart';

class TunerPage extends StatefulWidget {
  const TunerPage({super.key});

  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  final TunerStore _store = GetIt.I<TunerStore>();
  final PermissionService _permissionService = GetIt.I<PermissionService>();

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStart();
  }

  Future<void> _checkPermissionsAndStart() async {
    final hasPermission =
        await _permissionService.requestMicrophonePermission();
    if (hasPermission) {
      await _store.start();
    } else {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permissão Necessária'),
            content: const Text(
                'Precisamos do microfone para ouvir sua guitarra. Por favor, habilite nas configurações.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  _permissionService.openSettings();
                  Navigator.pop(context);
                },
                child: const Text('Configurações'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _store.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // backgroundColor: Colors.black, // Removed to use theme background
      appBar: AppBar(
        title: const Text('Afinador'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Observer(
        builder: (_) {
          final isTune = _store.status == TunerStatus.inTune;
          final color = isTune
              ? Colors.greenAccent
              : (_store.status == TunerStatus.none
                  ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                  : Colors.redAccent);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Needle / Gauge
                SizedBox(
                  height: 200,
                  width: 300,
                  child: CustomPaint(
                    painter: GaugePainter(
                      cents: _store.centsDiff,
                      color: color,
                      arcColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      pivotColor: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Note Display
                Text(
                  _store.currentNote,
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: color,
                    shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: color.withValues(alpha: 0.5),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Frequency Display
                Text(
                  '${_store.currentFrequency.toStringAsFixed(1)} Hz',
                  style: TextStyle(
                    fontSize: 24,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 10),
                // Status Text
                Text(
                  _store.status == TunerStatus.inTune
                      ? 'AFINADO'
                      : (_store.status == TunerStatus.flat
                          ? 'BAIXO (Aperte)'
                          : (_store.status == TunerStatus.sharp
                              ? 'ALTO (Solte)'
                              : 'Toque uma corda')),
                  style: TextStyle(
                    fontSize: 18,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double cents;
  final Color color;
  final Color arcColor;
  final Color pivotColor;

  GaugePainter({
    required this.cents,
    required this.color,
    required this.arcColor,
    required this.pivotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Draw Arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      paint,
    );

    // Draw Center Marker
    paint.color = Colors.green.withValues(alpha: 0.3);
    paint.strokeWidth = 5;
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy - radius),
      paint,
    );

    // Draw Needle
    final double normalizedCents = cents.clamp(-50.0, 50.0);
    final double angle = math.pi + (normalizedCents + 50) * (math.pi / 100);

    final needlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final needleEnd = Offset(
      center.dx + (radius - 20) * math.cos(angle),
      center.dy + (radius - 20) * math.sin(angle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw Pivot
    canvas.drawCircle(center, 15, Paint()..color = pivotColor);
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.cents != cents || oldDelegate.color != color;
  }
}
