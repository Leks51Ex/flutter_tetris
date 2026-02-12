import 'package:flutter/material.dart';
import 'package:flutter_tetris/app/context_ext.dart';
import 'package:flutter_tetris/features/leaderboard/domain/leader_board_entity.dart';
import 'package:flutter_tetris/features/leaderboard/domain/state/leader_board_cubit.dart';
import 'package:flutter_tetris/features/leaderboard/domain/state/leader_board_state.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  late final LeaderBoardCubit leaderBoardCubit;



  @override
  void initState() {
      
      super.initState();
      leaderBoardCubit = LeaderBoardCubit(repository: context.di.leaderRepository)..fetchLeaderboard();
  }
 @override
  void dispose() {
    // При завершении работы виджета
    // освобождаем ресурсы кубита
    leaderBoardCubit.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Таблица лидеров'),
        actions: [
          IconButton(onPressed: leaderBoardCubit.fetchLeaderboard, icon: Icon(Icons.refresh)),
        ],
      ),
      body: ValueListenableBuilder(valueListenable: leaderBoardCubit.stateNotifier, builder: (context, state, child)
=> switch(state){
            LeaderBoardInitState() =>
            const Center(child: Text('Инициализация...')),
                     LeaderboardLoading() =>
            const Center(child: CircularProgressIndicator()),
                      LeaderboardSuccessState() => _ListRecords(state.leaderboard),
                       LeaderboardErrorState() => Center(
              child: Text(
                'Ошибка: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
}
      ),
    );
  }
}



class _ListRecords extends StatelessWidget {
  const _ListRecords(this.leaderBoard);
  
  final List<LeaderBoardEntity> leaderBoard;
  @override
  Widget build(BuildContext context) {
      if (leaderBoard.isEmpty) {
      return const Center(child: Text('Нет записей в таблице лидеров'));
      
    }
    
    
    
    return ListView.builder(
      
         itemCount: leaderBoard.length,
      itemBuilder: (context, index){
      final LeaderBoardEntity item = leaderBoard[index];
      return ListTile(
        title: Text(item.username),
          subtitle: Text('Очки: ${item.score}'),
      );
    });
  }
}