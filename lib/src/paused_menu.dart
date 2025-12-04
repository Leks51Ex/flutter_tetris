import 'package:flutter/material.dart';

class PausedMenu extends StatelessWidget {
  final VoidCallback backToGame;

  const PausedMenu({super.key, required this.backToGame});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Пауза',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(onPressed: backToGame, child: Text('Назад')),
      ],
    );
  }
}
