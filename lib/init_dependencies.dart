import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_player/data/datasources/local_data_source.dart';
import 'package:mplayer/features/music_player/data/repository/repository_impl.dart';
import 'package:mplayer/features/music_player/domain/repository/repository.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_all.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_from_cache.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
 	await Hive.initFlutter(); 
	final musicbox = await Hive.openBox('music');
  serviceLocator.registerSingleton<Box>(musicbox);
  serviceLocator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      box: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<MusicRepository>(
    () => RepositoryImpl(localDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => FetchAll(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => FetchFromCache(repository: serviceLocator()),
  );

	serviceLocator.registerFactory(() => AudioPlayer());

  serviceLocator.registerLazySingleton(
    () => MusicBloc(
			player: serviceLocator(),
      fetchAll: serviceLocator(),
      fetchFromCache: serviceLocator(),
    ),
  );
	serviceLocator.registerLazySingleton(() => MusicControlBloc(player: serviceLocator()));
}
