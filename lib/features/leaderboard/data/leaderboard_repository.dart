


import 'dart:convert';

import 'package:flutter_tetris/app/http/i_http_client.dart';
import 'package:flutter_tetris/features/leaderboard/data/leaderboard_dto.dart';
import 'package:flutter_tetris/features/leaderboard/domain/i_leaderboard_repository.dart';
import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';

final class LeaderboardRepository implements ILeaderboardRepository {
  
   final IHttpClient httpClient;

   LeaderboardRepository({required this.httpClient});
  
  @override
  Future<Iterable<LeaderBoardEntity>> fetchLeaderboard()async {
      final response = await httpClient.get('/users/');
      
         if (response.statusCode != 200) {
      throw Exception('Ошибка при загрузке лидерборда: ${response.statusCode}');
    }

    final Iterable data = json.decode(response.body);
    final resList = data.map((item){
      return LeaderboardDto.fromJson(item).toEntity();
    }).toList();
    return resList;
        
  }
} 