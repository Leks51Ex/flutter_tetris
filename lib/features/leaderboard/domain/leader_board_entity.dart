import 'package:flutter/foundation.dart';
import 'package:flutter_tetris/app/equals_mixin.dart';



@immutable
class LeaderBoardEntity with EqualsMixin{
  
  final int id;

  final String username;


  final int score;


  const LeaderBoardEntity({
    required this.id,
    required this.score,
    required this.username,
  });
  
  
  @override
  List<Object?> get fields => [id, username, score];
}