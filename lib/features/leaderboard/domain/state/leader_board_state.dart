import 'package:flutter_tetris/app/equals_mixin.dart';
import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';

sealed class LeaderBoardState with EqualsMixin{
  const LeaderBoardState();

  @override
  List<Object?> get fields => [];
}



final class LeaderBoardInitState extends LeaderBoardState{
  const LeaderBoardInitState();
}


final class LeaderboardLoading extends LeaderBoardState {
  const LeaderboardLoading();
}


final class LeaderboardSuccessState extends LeaderBoardState {
  /// В случае успешной загрузки, 
  /// получаем список сущностей таблицы лидеров
  final List<LeaderBoardEntity> leaderboard;

  const LeaderboardSuccessState(this.leaderboard);

  @override
  List<Object?> get fields => [leaderboard];
}


final class LeaderboardErrorState extends LeaderBoardState {
  final String message;
  final Object error;
  final StackTrace? stackTrace;

  LeaderboardErrorState(
    this.message, {
    required this.error,
    this.stackTrace,
  });

  @override
  List<Object?> get fields => [message, error, stackTrace];
}