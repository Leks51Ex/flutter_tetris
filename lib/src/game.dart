// game.dart
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'blocks/blocks.dart';
import 'board.dart';

final class Game {
  late Board board;
  late Block currentBlock; // текущий блок
  late Block nextBlock; // следующий блок
  bool _isGameOver = false;
  int score = 0;

  Game({required this.onGameOver}) {
    currentBlock = getNewRandomBlock();
    nextBlock = getNewRandomBlock();

    board = Board(
      currentBlock: currentBlock,
      newBlockFunc: newBlock,
      updateScore: updateScore,
      updateBlock: updateBlock,
      gameOver: gameOver,
    );
    keyboardEventHandler();
  }

  // Метод обновления блока фигуры
  void updateBlock(Block block) {
    currentBlock = block;
  }

  // Метод обновления счета
  void updateScore() {
    score += 10;
  }

  // Метод генерации новой фигуры
  Block newBlock() {
    currentBlock = nextBlock;
    nextBlock = getNewRandomBlock();
    return currentBlock;
  }

  final Function(String scores) onGameOver;

  // Метод для установки прослушивания нажатий клавиш
  // и передачи ASCII-кода нажатой клавиши на уровень ниже
  void keyboardEventHandler() {}

  // Метод запуска игры
  Future<void> start({required VoidCallback onUpdate}) async {
    // Запускаем игровой цикл
    while (!_isGameOver) {
      nextStep();
      await Future.delayed(const Duration(milliseconds: 500));
      onUpdate(); // Вызывается на каждый цикл игры
    }
    onGameOver(score.toString()); // Вызывается при завершении игры
  }

  // Метод вывода текущего счета в игре
  void printScore() {}

  bool get isGameOver => _isGameOver;

  void gameOver() {
    _isGameOver = true;
  }

  // Метод обработки шага игрового цикла
  void nextStep() {
    var x = currentBlock.x;
    var y = currentBlock.y;

    if (!board.isFilledBlock(x, y + 1)) {
      board.moveBlock(x, y + 1);
    } else {
      board.clearLine();
      board.savePresentBoardToCpy();
      board.newBlock();
      board.drawBoard();
    }
  }

  Future<void> showMenu() async {}

  // Добавляем в класс Game (в любое место, например перед nextStep)
  void drawNextBlock() {}

  void togglePause() {}

  Future<bool> showGameOverMenu() async {
    return Future.value(true);
  }
}
