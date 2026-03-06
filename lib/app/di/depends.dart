import 'package:flutter_tetris/app/http/base_http_client.dart';
import 'package:flutter_tetris/app/http/i_http_client.dart';
import 'package:flutter_tetris/app/storage/i_storage_service.dart';
import 'package:flutter_tetris/app/storage/storage_service.dart';
import 'package:flutter_tetris/features/leaderboard/data/leaderboard_repository.dart';
import 'package:flutter_tetris/features/leaderboard/domain/i_leaderboard_repository.dart';
import 'package:flutter_tetris/features/user/data/user_repository.dart';
import 'package:flutter_tetris/features/user/domain/i_user_repository.dart';
import 'package:flutter_tetris/features/user/domain/state/user_cubit.dart';

class Depends {
  late final IStorageService storageService;

  /// Интерфейс HTTP клиента
  late final IHttpClient _httpClient;

  /// Интерфейс репозитория для работы с таблицей лидеров
  late final ILeaderboardRepository leaderRepository;

  /// Интерфейс репозитория для работы с пользователем
  late final IUserRepository _userRepository;

  /// Менеджер состояния пользователя
  late final UserCubit userCubit;
  static final Depends _instance = Depends._internal();

  factory Depends() {
    return _instance;
  }

  Depends._internal();

  Future<void> init() async {
    _httpClient = BaseHttpClient();
    storageService = StorageService();
    await storageService.init();

    leaderRepository = LeaderboardRepository(httpClient: _httpClient);

    _userRepository = UserRepository(
      httpClient: _httpClient,
      storageService: storageService,
    );

    userCubit = UserCubit(repository: _userRepository);
    await userCubit.restoreUser();
  }
}
