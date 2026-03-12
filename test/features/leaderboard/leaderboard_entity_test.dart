import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';

Future<void> main() async {
  group('LeaderBoardEntityTests', () {
    test('Test leader board entity comparation', () {
      const dto1 = LeaderBoardEntity(id: 1, score: 150, username: 'Username1');
      const dto2 = LeaderBoardEntity(id: 1, score: 150, username: 'Username1');
      const dto3 = LeaderBoardEntity(id: 2, score: 150, username: 'Username1');
      expect(dto1, equals(dto2));
      expect(dto3, isNot(equals(dto1)));
    });
  });
}
