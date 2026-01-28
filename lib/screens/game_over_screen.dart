import 'package:flutter/material.dart';
import 'package:flutter_tetris/main.dart';
import 'package:flutter_tetris/src/game_scores.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});




  @override
  Widget build(BuildContext context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final scores = int.tryParse(args.toString()) ?? 0;
    return Scaffold(
       body: GameScores(onRestart: (){
           Navigator.pushReplacementNamed(
                context, 
                GameRouter.gameRoute,
             );
       }, score: scores, level: scores),
    );
  }
}