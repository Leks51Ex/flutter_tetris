import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/context_ext.dart';
import 'package:flutter_tetris/features/user/domain/state/user_state.dart';
import 'package:flutter_tetris/main.dart';
import 'package:flutter_tetris/features/game/game_scores.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: context.di.userCubit.stateNotifier,
          builder: (context, state, child) {
            return switch (state) {
              UserLoadingState() => CircularProgressIndicator(),
              UserSuccessState() => GameScores(
                score: state.userEntity.score,
                onRestart: () {
                  Navigator.pushReplacementNamed(context, GameRouter.gameRoute);
                },
                level: 0,
              ),
              _ => SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
