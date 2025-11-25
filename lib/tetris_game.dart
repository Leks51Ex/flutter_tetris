import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/src/blocks/blocks.dart';
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

class NextBlockPreview extends StatelessWidget {
  final Block block;
  final double blockSize;

  const NextBlockPreview({
    super.key,
    required this.block,
    required this.blockSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(blockSize * 4, blockSize * 4),
      painter: _NextBlockPainter(block, blockSize),
    );
  }
}

class _NextBlockPainter extends CustomPainter {
  final Block block;
  final double size;

  _NextBlockPainter(this.block, this.size);

  @override
  void paint(Canvas canvas, Size s) {
    final paint = Paint()..color = Colors.red;

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (block[i][j] == 1) {
          canvas.drawRect(Rect.fromLTWH(j * size, i * size, size, size), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_) => true;
}

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  late Game game;
  bool _pauseDialogShown = false;
  final FocusNode _pauseDialogFocusNode = FocusNode();

  void _showGameOverDialog(String scores) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              AlertDialog(
                title: Text('Game over'),
                content: Text(
                  'Your score: $scores\n Your level: ${game.level}',
                ),
                actions: [
                  ElevatedButton(
                    onPressed: _restartGame,
                    child: Text('Еще раз!'),
                  ),
                ],
              ),
            ],
          );
        },
      );
    });
  }

  void _restartGame() {
    Navigator.of(context).pop();
    setState(() {
      game = Game(onGameOver: _showGameOverDialog, onPause: _showPauseDialog);

      // запускаем заново игровой цикл
      game.start(
        onUpdate: () {
          setState(() {});
        },
      );
    });
  }

  void _showPauseDialog(bool isPaused) {
    if (!mounted) return;

    // Показать модалку
    if (isPaused && !_pauseDialogShown) {
      _pauseDialogShown = true;

      // showDialog вернёт Future, который завершится когда диалог будет закрыт
      showDialog(
        context: context,
        barrierDismissible: false, // не закрывать кликом вне
        builder: (_) {
          // RawKeyboardListener перехватит ESC внутри диалога
          return RawKeyboardListener(
            focusNode: _pauseDialogFocusNode,
            onKey: (RawKeyEvent event) {
              if (event is RawKeyUpEvent &&
                  event.logicalKey == LogicalKeyboardKey.escape) {
                game.toglePause();
              }
            },
            child: AlertDialog(
              title: const Text('Пауза'),
              content: const Text(
                'Игра приостановлена\nНажмите ESC, чтобы продолжить',
              ),
              // без кнопок — управление только ESC
            ),
          );
        },
      ).then((_) {
        // диалог закрыт (например через onPauseToggle), восстанавливаем флаг и отпускаем фокус
        _pauseDialogShown = false;
        if (_pauseDialogFocusNode.hasFocus) {
          _pauseDialogFocusNode.unfocus();
        }
      });

      // Запросить фокус для RawKeyboardListener после построения диалога
      // (делаем через postFrameCallback чтобы нода существовала)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pauseDialogShown) {
          _pauseDialogFocusNode.requestFocus();
        }
      });

      return;
    }

    // Закрыть модалку: вызывается когда game.togglePause() установит isPaused = false
    if (!isPaused && _pauseDialogShown) {
      Navigator.of(
        context,
      ).pop(); // безопасно: мы точно закрываем открытый диалог
      // _pauseDialogShown будет сброшен в .then((_) {...}) выше
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    game = Game(onGameOver: _showGameOverDialog, onPause: _showPauseDialog);
    game.start(
      onUpdate: () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _pauseDialogFocusNode.dispose();
    super.dispose();
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

        ///PAUSE
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          game.toglePause();
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
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      painter: _GamePainter(board, blockSize),
                      size: Size(
                        board[0].length * blockSize,
                        board.length * blockSize,
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        child: Text(
                          'Score: ${game.score}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                /// ---- Блок next ----
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level: ${game.level}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Next:",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    NextBlockPreview(
                      block: game.nextBlock,
                      blockSize: blockSize * 0.8,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
