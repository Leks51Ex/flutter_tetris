// base_url/5/tetris/lib/app/di_container.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_tetris/app/http/base_http_client.dart';
import 'package:flutter_tetris/app/http/i_http_client.dart';

final class DiContainer extends InheritedWidget {
  DiContainer({super.key, required super.child}){
    // Инициализируем контейнер зависимостей
    _httpClient = BaseHttpClient();
  }

  late final IHttpClient _httpClient;

  /// Так как контейнер зависимостей нужен только для доступа 
  /// к зависимостям – возвращаем false, чтобы виджеты-потомки 
  /// не перестраивались при изменении контекста 
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;


  /// Получение контейнера зависимостей из контекста
  static DiContainer of(BuildContext context) {
    // Ищем контейнер зависимостей в контексте
    // Если не нашли, то выбрасываем исключение
    final DiContainer? container =
        context.getInheritedWidgetOfExactType<DiContainer>();
    if (container == null) {
      throw Exception('Контейнер зависимостей не найден в контексте');
    }
    return container;
  }
}
