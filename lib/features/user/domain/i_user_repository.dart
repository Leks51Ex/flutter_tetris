import 'package:flutter_tetris/features/user/domain/user_entity.dart';

abstract interface class IUserRepository {
  Future<UserEntity> createUser(String username);

  Future<UserEntity> setScores(String username, int scores);
}
