import 'dart:convert';

import 'package:flutter_tetris/app/http/i_http_client.dart';
import 'package:flutter_tetris/features/user/data/user_dto.dart';
import 'package:flutter_tetris/features/user/domain/i_user_repository.dart';
import 'package:flutter_tetris/features/user/domain/user_entity.dart';

final class UserRepository implements IUserRepository {
  final IHttpClient httpClient;

  UserRepository({required this.httpClient});

  @override
  Future<UserEntity> createUser(String username) async {
    final response = await httpClient.post(
      '/users/',
      body: {'username': username},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Ошибка при создании пользователя: ${response.statusCode}',
      );
    }
    return UserDto.fromJson(json.decode(response.body)).toEntity();
  }

  @override
  Future<UserEntity> setScores(String username, int scores) async {
    final response = await httpClient.put(
      '/users/scores',
      body: {"username": username, "score": scores},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Ошибка при обновлении пользователя: ${response.statusCode}',
      );
    }
    return UserDto.fromJson(json.decode(response.body)).toEntity();
  }
}
