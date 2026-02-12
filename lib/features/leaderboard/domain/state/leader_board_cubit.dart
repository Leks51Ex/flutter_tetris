import 'package:flutter/material.dart';
import 'package:flutter_tetris/features/leaderboard/domain/i_leaderboard_repository.dart';
import 'package:flutter_tetris/features/leaderboard/domain/state/leader_board_state.dart';

class LeaderBoardCubit {
  final ILeaderboardRepository repository;

  final ValueNotifier<LeaderBoardState> stateNotifier = ValueNotifier(LeaderBoardInitState());

  LeaderBoardCubit({required this.repository});



  void emit(LeaderBoardState cubitState){
    stateNotifier.value = cubitState;
  }

  Future<void>fetchLeaderboard()async{
    if (stateNotifier.value is LeaderboardLoading) {
      return;
    }

    try {
      emit(const LeaderboardLoading());
      final leaderboard = await repository.fetchLeaderboard();
      emit(LeaderboardSuccessState(leaderboard.toList()));
    } on Object catch (e, stackTrace){
      emit(LeaderboardErrorState('Ошибка загрузки таблицы лидеров',
        error: e,
        stackTrace: stackTrace,));
    }
  }
    
   void dispose() {
    stateNotifier.dispose();
  }
}