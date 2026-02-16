import 'package:flutter/foundation.dart';
import 'package:flutter_tetris/features/user/domain/i_user_repository.dart';
import 'package:flutter_tetris/features/user/domain/state/user_state.dart';

class UserCubit {
  final IUserRepository repository;

  UserCubit({required this.repository});

  final ValueNotifier<UserState> stateNotifier = ValueNotifier(UserInitState());

  Future<void> createUser(String username) async {
    // Проверка состояния, если состояние загрузки, то не выполнять запрос
    // и не перезаписывать состояние
    if (stateNotifier.value is UserLoadingState) return;

    try {
      emit(UserLoadingState());
      final entity = await repository.createUser(username);
      emit(UserSuccessState(entity));
    } on Object catch (error, stackTrace) {
      emit(
        UserErrorState(
          'Ошибка создания пользователя',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> setScores(String username, int scores) async {
    if (stateNotifier.value is UserLoadingState) {
      return;
    }

    try {
      emit(UserLoadingState());
      final entity = await repository.setScores(username, scores);
      emit(UserSuccessState(entity));
    } on Object catch (error, stackTrace) {
      emit(
        UserErrorState(
          'Ошибка обновления результата пользователя',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  void signOut() {
    emit(UserInitState());
  }

  void reset() {
    emit(UserInitState());
  }

  void emit(UserState cubitState) {
    stateNotifier.value = cubitState;
  }
}
