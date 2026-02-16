import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/context_ext.dart';
import 'package:flutter_tetris/main.dart';

class UserError extends StatelessWidget {
  final String message;
  final String username;
  const UserError({super.key, required this.message, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.di.userCubit.reset();
            context.di.userCubit.createUser(username);
          },
          child: Text('Попробовать снова'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, GameRouter.initialRoute);
          },
          child: Text('Вернуться в главное меню'),
        ),
      ],
    );
  }
}
