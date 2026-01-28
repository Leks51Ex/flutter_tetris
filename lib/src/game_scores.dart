import 'package:flutter/material.dart';

class GameScores extends StatelessWidget {
  final int score;
  final int level;

  final VoidCallback onRestart;

  const GameScores({
    super.key,
    required this.onRestart,
    required this.score,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Заработанные очки: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Уровень: $level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onRestart, child: Text('Restart game!')),
          ],
        ),
      ),
    );
  }
}
