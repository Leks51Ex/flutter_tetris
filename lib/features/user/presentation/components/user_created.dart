import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/context_ext.dart';
import 'package:flutter_tetris/features/user/domain/user_entity.dart';
import 'package:flutter_tetris/main.dart';

class UserCreated extends StatelessWidget {
  const UserCreated({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Добро пожаловать, ${userEntity.username}'),
        SizedBox(height: 16),
        Text('Ваш лучший результат: ${userEntity.score}'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, GameRouter.gameRoute);
          },
          child: Text('Начать игру'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.di.userCubit.signOut();
          },
          child: Text('Выйти из аккаунта'),
        ),
      ],
    );
  }
}
