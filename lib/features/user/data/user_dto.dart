import 'package:flutter_tetris/features/user/domain/user_entity.dart';

final class UserDto {
  final int id;

  final String username;

  final int score;

  const UserDto({
    required this.id,
    required this.score,
    required this.username,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      username: json['username'] as String,
      score: json['score'] ?? 0,
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, username: username, score: score);
  }
}
