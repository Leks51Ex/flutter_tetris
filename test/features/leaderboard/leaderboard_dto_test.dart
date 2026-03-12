import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tetris/features/leaderboard/data/leaderboard_dto.dart';

void main() {
  group('LeaderBoardDto tests', () {
    group('FromJson test', () {
      test('Json incoming', () {
        final json = {'id': 1, 'username': 'testUser', 'score': 150};
        final dto = LeaderboardDto.fromJson(json);

        expect(dto.id, 1);
        expect(dto.username, 'testUser');
        expect(dto.score, 150);
      });

      test('Score is apcent', () {
        final json = {'id': 1, 'username': 'testUser'};
        final dto = LeaderboardDto.fromJson(json);
        expect(dto.score, 0);
      });
      test('id is not int', () {
        final json = {'id': '1', 'username': 'user', 'score': 100};

        expect(() => LeaderboardDto.fromJson(json), throwsA(isA<TypeError>()));
      });

      test('json is empty', () {
        final json = <String, dynamic>{};
        expect(() => LeaderboardDto.fromJson(json), throwsA(isA<TypeError>()));
      });
    });

    group('ToEntity test', () {
      test('Test dto to entity transform', () {
        final dto = LeaderboardDto(id: 1, username: 'testUser', score: 150);
        final entity = dto.toEntity();
        expect(entity.id, 1);
        expect(entity.username, 'testUser');
        expect(entity.score, 150);
      });
    });
    group('To json test', () {
      test('Test dto to json transform', () {
        final dto = LeaderboardDto(id: 1, username: 'testUser', score: 150);
        final json = {
          'id': dto.id,
          'username': dto.username,
          'score': dto.score,
        };
        expect(json['id'], 1);
        expect(json['username'], 'testUser');
        expect(json['score'], 150);
      });
    });
  });
}
