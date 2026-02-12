import 'package:flutter/material.dart';

import '../../main.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed:() {
                 Navigator.pushReplacementNamed(
                    context, 
                    GameRouter.gameRoute,
                 );
            }, child: Text(
              'Начать игру'
            )),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, GameRouter.leaderboardRoute);
            }, child: Text('Лучшие результаты'))
          ],
        ),
      ),
    );
  }
}