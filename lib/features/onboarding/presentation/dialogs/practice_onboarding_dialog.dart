import 'package:flutter/material.dart';

class PracticeOnboardingDialog extends StatelessWidget {
  const PracticeOnboardingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Método de Prática Inteligente'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bem-vindo ao seu novo sistema de treino!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
                '1. Aquecimento (Warmup): Começamos devagar para soltar os dedos.'),
            SizedBox(height: 8),
            Text(
                '2. Calibragem: O sistema ajusta a velocidade ideal para você.'),
            SizedBox(height: 8),
            Text('3. Treino: Aumentamos o BPM progressivamente.'),
            SizedBox(height: 16),
            Text('Pronto para evoluir?'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('VAMOS LÁ!'),
        ),
      ],
    );
  }
}
