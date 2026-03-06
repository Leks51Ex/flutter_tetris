import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/di/depends.dart';
import 'package:flutter_tetris/app/di/di_container.dart';
import 'package:flutter_tetris/features/leaderboard/presentation/leader_board_screen.dart';
import 'package:flutter_tetris/features/user/presentation/user_screen.dart';

import 'package:flutter_tetris/features/game/game_over_screen.dart';
import 'package:flutter_tetris/features/game/game_screen.dart';
import 'package:flutter_tetris/features/main_menu/main_menu_screen.dart';

part 'app/game_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Depends depends = Depends();

  try {
    await depends.init();
    runApp(_MyApp(depends: depends));
  } on Object catch (error, stackTrace) {
    runApp(AppError(error: error, stackTrace: stackTrace));
  }
}

class AppError extends StatelessWidget {
  const AppError({super.key, required this.error, required this.stackTrace});

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Произошла ошибка:'),
              Text(error.toString()),
              Text(stackTrace.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({required this.depends});

  final Depends depends;
  @override
  Widget build(BuildContext context) {
    return DiContainer(
      depends: depends,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: GameRouter.initialRoute,
        routes: GameRouter._appRoutes,
      ),
    );
  }
}
