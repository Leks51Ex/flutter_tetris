// game.dart
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'blocks/blocks.dart';
import 'board.dart';

// final class Game extends ChangeNotifier {
//   late Board board;
//   late Block currentBlock;
//   late Block nextBlock;
//   bool _isGameOver = false;
//   int score = 0;
//   int level = 0;
//   bool _isPaused = false;

//   Game({required this.onGameOver, required this.onPause}) {
//     currentBlock = getNewRandomBlock();
//     nextBlock = getNewRandomBlock();

//     board = Board(
//       currentBlock: currentBlock,
//       newBlockFunc: newBlock,
//       updateScore: updateScore,
//       updateBlock: updateBlock,
//       gameOver: gameOver,
//     );
//     keyboardEventHandler();
//   }

//   // Метод обновления блока фигуры
//   void updateBlock(Block block) {
//     currentBlock = block;
//     notifyListeners();
//   }

//   void toglePause() {
//     _isPaused = !_isPaused;
//     onPause(_isPaused);
//   }

//   // Метод обновления счета
//   void updateScore() {
//     score += 10;
//     notifyListeners();
//   }

//   // Метод генерации новой фигуры
//   Block newBlock() {
//     currentBlock = nextBlock;
//     nextBlock = getNewRandomBlock();
//     return currentBlock;
//   }

//   final Function(String scores) onGameOver;
//   final Function(bool isPaused) onPause;

//   // Метод для установки прослушивания нажатий клавиш
//   // и передачи ASCII-кода нажатой клавиши на уровень ниже
//   void keyboardEventHandler() {}

//   // Метод запуска игры
//   Future<void> start({required VoidCallback onUpdate}) async {
//     // Запускаем игровой цикл
//     while (!_isGameOver) {
//       if (!_isPaused) {
//         nextStep();
//         onUpdate();
//       }
//       level = score ~/ 30 + 1;
//       int delayMs = 500 - (level - 1) * 50;
//       if (delayMs < 100) delayMs = 100;

//       await Future.delayed(Duration(milliseconds: delayMs));
//       // Вызывается на каждый цикл игры
//     }
//     onGameOver(score.toString()); // Вызывается при завершении игры
//   }

//     Future<void> restart() async {
//     _isGameOver = false;
//     score = 0;
//     board = Board(
//       currentBlock: currentBlock,
//       newBlockFunc: newBlock,
//       updateScore: updateScore,
//       updateBlock: updateBlock,
//       gameOver: gameOver,
//     );
//     start();
//   }

//   // Метод вывода текущего счета в игре
//   void printScore() {}

//   bool get isGameOver => _isGameOver;

//   void gameOver() {
//     _isGameOver = true;
//     notifyListeners();
//   }

//   // Метод обработки шага игрового цикла
//   void nextStep() {
//     var x = currentBlock.x;
//     var y = currentBlock.y;

//     if (!board.isFilledBlock(x, y + 1)) {
//       board.moveBlock(x, y + 1);
//     } else {
//       board.clearLine();
//       board.savePresentBoardToCpy();
//       board.newBlock();
//       board.drawBoard();
//     }

//     notifyListeners();
//   }

//   Future<void> showMenu() async {}

//   // Добавляем в класс Game (в любое место, например перед nextStep)
//   void drawNextBlock() {}

//   Future<bool> showGameOverMenu() async {
//     return Future.value(true);
//   }
// }
final class Game extends ChangeNotifier {
  late Board board; // Сделаем открытым
  late Block currentBlock;
  late Block nextBlock;
  bool _isGameOver = false;
  bool _isPaused = false;
  int score = 0;
  int level = 0;

  // Обратный вызов при окончании игры
  final Function(String scores) onGameOver;
  final Function(bool isPaused) onPaused;

  Game({required this.onGameOver, required this.onPaused}) {
    currentBlock = getNewRandomBlock();
    nextBlock = getNewRandomBlock();

    board = Board(
      currentBlock: currentBlock,
      newBlockFunc: newBlock,
      updateScore: updateScore,
      updateBlock: updateBlock,
      gameOver: gameOver,
    );
  }

  // Метод обновления блока фигуры
  void updateBlock(Block block) {
    currentBlock = block;
    // Уведомляем слушателей об изменениях в блоке
    // Когда пользователь нажимает на кнопку
    notifyListeners();
  }

  // Метод обновления счета
  void updateScore() {
    score += 10;
    // Уведомляем слушателей об изменениях в счете
    // Для возможности обновления счета на экране
    notifyListeners();
  }

  // Метод генерации новой фигуры
  Block newBlock() {
    currentBlock = nextBlock;
    nextBlock = getNewRandomBlock();
    return currentBlock;
  }

  void toglePause() {
    _isPaused = !_isPaused;
    onPaused(_isPaused);
    notifyListeners();
  }

  // Метод запуска игры
  Future<void> start() async {
    // Запускаем игровой цикл
    while (!_isGameOver) {
      if (!_isPaused) {
        nextStep();
      }

      level = score ~/ 30 + 1;
      int delayMs = 500 - (level - 1) * 50;
      if (delayMs < 100) delayMs = 100;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  //   Future<void> start({required VoidCallback onUpdate}) async {

  Future<void> restart() async {
    _isGameOver = false;
    score = 0;
    board = Board(
      currentBlock: currentBlock,
      newBlockFunc: newBlock,
      updateScore: updateScore,
      updateBlock: updateBlock,
      gameOver: gameOver,
    );
    start();
  }

  // Метод вывода текущего счета в игре
  void printScore() {}

  bool get isGameOver => _isGameOver;
  bool get isPaused => _isPaused;

  void gameOver() {
    _isGameOver = true;
    // Уведомляем слушателей об окончании игры
    notifyListeners();
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

    // Уведомляем слушателей после каждого шага
    notifyListeners();
  }
}
