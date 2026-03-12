import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/features/leaderboard/domain/i_leaderboard_repository.dart';
import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';
import 'package:flutter_tetris/features/leaderboard/domain/state/leader_board_cubit.dart';
import 'package:flutter_tetris/features/leaderboard/domain/state/leader_board_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'leaderboard_cubit_test.mocks.dart';

List<LeaderBoardEntity> _fakeLeaderBoard = [
  LeaderBoardEntity(id: 1, username: 'User1', score: 100),
  LeaderBoardEntity(id: 2, username: 'User2', score: 200),
  LeaderBoardEntity(id: 3, username: 'User3', score: 300),
];

@GenerateNiceMocks([MockSpec<ILeaderboardRepository>()])
Future<void> main() async {
  late ILeaderboardRepository repository;
  late LeaderBoardCubit cubit;

  setUp(() {
    repository = MockILeaderboardRepository();
    cubit = LeaderBoardCubit(repository: repository);
  });

  tearDown(() {
    cubit.dispose();
  });

  group('Test LeaderBoardCubit', () {
    test('Test get leader board table with exception', () async {
      expect(cubit.stateNotifier.value, isA<LeaderBoardInitState>());

      // Имитация метода fetchLeaderboard с ошибкой
      when(
        repository.fetchLeaderboard(),
      ).thenThrow(Exception('Ошибка загрузки таблицы лидеров'));

      /// Проверка, что метод fetchLeaderboard не был
      /// завершен успешно
      verifyNever(repository.fetchLeaderboard());
      // Запуск метода fetchLeaderboard

      await cubit.fetchLeaderboard();

      // Проверка, что состояние кубита - LeaderboardErrorState
      expect(cubit.stateNotifier.value, isA<LeaderboardErrorState>());
    });

    test('Test success leader board table', () async {
      expect(cubit.stateNotifier.value, isA<LeaderBoardInitState>());
      when(
        repository.fetchLeaderboard(),
      ).thenAnswer((_) async => _fakeLeaderBoard);

      await cubit.fetchLeaderboard();

      // Проверка, что метод fetchLeaderboard был вызван
      // один раз
      verify(repository.fetchLeaderboard()).called(1);

      // Проверка конечного состояния
      expect(cubit.stateNotifier.value, isA<LeaderboardSuccessState>());
      expect(
        (cubit.stateNotifier.value as LeaderboardSuccessState).leaderboard,
        _fakeLeaderBoard,
      );
    });
  });
}
