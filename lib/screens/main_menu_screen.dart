import 'package:flutter/material.dart';

import '../main.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed:() {
             Navigator.pushReplacementNamed(
                context, 
                GameRouter.gameRoute,
             );
        }, child: Text(
          'Начать игру'
        )),
      ),
    );
  }
}