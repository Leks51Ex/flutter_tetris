import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetris_game.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: TetrisGame()),
    );
  }
}
