part of '../main.dart';

abstract final class GameRouter {
  static const String initialRoute = '/';

  static const String gameRoute = '/game';

  static const String gameOverRoute = '/game_over';

  static const String leaderboardRoute = '/leaderboard';

  static const String userRouter = '/user';

  static final Map<String, WidgetBuilder> _appRoutes = {
    initialRoute: (_) => const MainMenuScreen(),
    gameRoute: (_) => const GameScreen(),
    gameOverRoute: (_) => const GameOverScreen(),

    leaderboardRoute: (_) => const LeaderBoardScreen(),
    userRouter: (_) => const UserScreen(),
  };
}
