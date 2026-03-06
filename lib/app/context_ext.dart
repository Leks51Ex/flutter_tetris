// base_url/5/tetris/lib/app/context_ext.dart
import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/di/depends.dart';
import 'package:flutter_tetris/app/di/di_container.dart';

/// Удобный доступ к контейнеру зависимостей
/// из любого места приложения через BuildContext
extension ContextExt on BuildContext {
  Depends get di => DiContainer.of(this).depends;
}
