import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/src/blocks/blocks.dart';
import 'package:flutter_tetris/src/board.dart';
import 'package:flutter_tetris/src/game.dart';
import 'package:flutter_tetris/src/game_scores.dart';
import 'package:flutter_tetris/src/paused_menu.dart';

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

  @override
  void initState() {
    super.initState();
    game = Game(onGameOver: (scores) {}, onPaused: (bool isPaused) {});
    game.start();
  }

  @override
  Widget build(BuildContext context) {
    // Добавляем слушателя для обновления состояния виджета
    return ListenableBuilder(
      // Передаем игру в качестве объекта, реализующего Listenable
      listenable: game,
      // Перестраиваем виджет при изменении состояния игры
      builder: (context, _) {
        if (game.isGameOver) {
          return Center(
            child: GameScores(
              level: game.level,
              score: game.score,
              onRestart: () {
                game.restart();
              },
            ),
          );
        }

        return Focus(
          autofocus: true,
          onKeyEvent: (FocusNode node, KeyEvent event) {
            if (event is KeyDownEvent || event is KeyRepeatEvent) {
              // ===== ДОБАВЛЯЕМ ПАУЗУ ПО ESC =====
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                game.toglePause();
                return KeyEventResult.handled;
              }

              game.board.keyboardEventHandler(event.logicalKey.keyId);
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
                if (game.isPaused) {
                  return Center(
                    child: PausedMenu(backToGame: () => game.toglePause()),
                  );
                }
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
                            child: Column(
                              children: [
                                Text(
                                  'Score: ${game.score}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Level: ${game.level}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
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
      },
    );
  }
}
