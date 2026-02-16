import 'package:flutter_tetris/app/equals_mixin.dart';
import 'package:flutter_tetris/features/user/domain/user_entity.dart';

sealed class UserState with EqualsMixin {
  const UserState();

  @override
  List<Object?> get fields => [];
}

final class UserInitState extends UserState {
  const UserInitState();
}

final class UserLoadingState extends UserState {
  const UserLoadingState();
}

final class UserSuccessState extends UserState {
  final UserEntity userEntity;

  const UserSuccessState(this.userEntity);

  @override
  List<Object?> get fields => [userEntity];
}

final class UserErrorState extends UserState {
  final String message;
  final Object error;
  final StackTrace? stackTrace;

  const UserErrorState(this.message, {required this.error, this.stackTrace});

  @override
  List<Object?> get fields => [message, error, stackTrace];
}
