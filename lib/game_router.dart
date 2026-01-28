part of 'main.dart';




abstract final class GameRouter {
  static const String initialRoute = '/';

  static const String gameRoute = '/game';

  static const String gameOverRoute = '/game_over';


  static final Map<String, WidgetBuilder> _appRoutes = {
    initialRoute: (_)=> const MainMenuScreen(),
      gameRoute: (_) => const GameScreen(),
    // Экран окончания игры
    gameOverRoute: (_) => const GameOverScreen(),
  }
  ;
}