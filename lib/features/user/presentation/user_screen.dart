import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/context_ext.dart';
import 'package:flutter_tetris/features/user/domain/state/user_state.dart';
import 'package:flutter_tetris/features/user/presentation/components/user_created.dart';
import 'package:flutter_tetris/features/user/presentation/components/user_error.dart';
import 'package:flutter_tetris/features/user/presentation/components/username_field.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: context.di.userCubit.stateNotifier,
            builder: (context, state, child) {
              return switch (state) {
                UserInitState() => UsernameField(controller: _controller),
                UserLoadingState() => CircularProgressIndicator(),
                UserSuccessState() => UserCreated(userEntity: state.userEntity),
                UserErrorState() => UserError(
                  message: state.message,
                  username: _controller.text,
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}
