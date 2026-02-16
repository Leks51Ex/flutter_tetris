import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/di_container.dart';
import 'package:flutter_tetris/features/leaderboard/presentation/leader_board_screen.dart';
import 'package:flutter_tetris/features/user/presentation/user_screen.dart';
import 'package:flutter_tetris/features/game/tetris_game.dart';

import 'package:flutter_tetris/features/game/game_over_screen.dart';
import 'package:flutter_tetris/features/game/game_screen.dart';
import 'package:flutter_tetris/features/main_menu/main_menu_screen.dart';

part 'app/game_router.dart';

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
