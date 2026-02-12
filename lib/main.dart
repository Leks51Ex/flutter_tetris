import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/di_container.dart';
import 'package:flutter_tetris/tetris_game.dart';


import 'package:flutter_tetris/screens/game_over_screen.dart';
import 'package:flutter_tetris/screens/game_screen.dart';
import 'package:flutter_tetris/screens/main_menu_screen.dart';



part 'game_router.dart';
void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DiContainer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: GameRouter.initialRoute,
        routes: GameRouter._appRoutes,
      ),
    );
  }
}
