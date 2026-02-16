import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tetris/app/equals_mixin.dart';

@immutable
class UserEntity with EqualsMixin {
  final int id;

  final String username;

  final int score;

  const UserEntity({
    required this.id,
    required this.username,
    required this.score,
  });

  @override
  List<Object?> get fields => [id, username, score];
}
