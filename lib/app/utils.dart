import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/context_ext.dart';
import 'package:flutter_tetris/features/user/domain/state/user_state.dart';

abstract class Utils {
  static String getUsername(BuildContext context) {
    final state = context.di.userCubit.stateNotifier.value;
    if (state is UserSuccessState) {
      return state.userEntity.username;
    } else {
      return 'Гость';
    }
  }
}
