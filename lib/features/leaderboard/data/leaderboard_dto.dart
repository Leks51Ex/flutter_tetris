import 'package:flutter/foundation.dart';
import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';


@immutable
final class LeaderboardDto {
  final int id;
  final String username;
  final int score;


  const LeaderboardDto({
    required this.id,
    required this.username,
    required this.score
  });

  factory LeaderboardDto.fromJson(Map<String, dynamic> json){
    return LeaderboardDto(
      id: json['id'] as int,
      username: json['username'] as String,
      score: json['score'] ?? 0,
    );
  }


  LeaderBoardEntity toEntity(){
     return  LeaderBoardEntity(
      id: id,
      username: username,
      score: score,
    );
  }
}