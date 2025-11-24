import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/src/board.dart';
import 'package:flutter_tetris/src/game.dart';

class _GamePainter extends CustomPainter {
  final List<List<int>> board;
  final double blockSize;

  _GamePainter(this.board, this.blockSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var i = 0; i < board.length; i++) {
      for (var j = 0; j < board[i].length; j++) {
        Rect rect = Rect.fromLTWH(
          j * blockSize,
          i * blockSize,
          blockSize,
          blockSize,
        );
        switch (board[i][j]) {
          case Board.posFree:
            paint.color = Colors.black;
          case Board.posFilled:
            paint.color = Colors.white;
          case Board.posBoarder:
            paint.color = Colors.red;
        }
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  late Game game;

  void _showGameOverDialog(String scores) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game over'),
            content: Text('Your score: $scores'),
            actions: [],
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    game = Game(onGameOver: _showGameOverDialog);
    game.start(
      onUpdate: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent || event is KeyRepeatEvent) {
          game.board.keyboardEventHandler(event.logicalKey.keyId);
          setState(() {});
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Align(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constrainst) {
            final board = game.board.mainBoard;
            double blockSize = min(
              constrainst.maxWidth / board[0].length,
              constrainst.maxHeight / board.length,
            );

            return CustomPaint(
              painter: _GamePainter(board, blockSize),
              size: Size(board[0].length * blockSize, board.length * blockSize),
            );
          },
        ),
      ),
    );
  }
}
