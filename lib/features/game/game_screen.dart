import 'package:flutter/material.dart';
import 'package:flutter_tetris/features/game/tetris_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TetrisGame());
  }
}
