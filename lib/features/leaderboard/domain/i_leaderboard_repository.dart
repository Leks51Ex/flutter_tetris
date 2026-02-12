import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';

abstract interface class ILeaderboardRepository {
  Future<Iterable<LeaderBoardEntity>> fetchLeaderboard();
}