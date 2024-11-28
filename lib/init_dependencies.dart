import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mplayer/features/music_player/data/datasources/local_data_source.dart';
import 'package:mplayer/features/music_player/data/repository/repository_impl.dart';
import 'package:mplayer/features/music_player/domain/repository/repository.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_all.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_from_cache.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_bloc.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'music'));
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

  serviceLocator.registerLazySingleton(
    () => MusicBloc(
      fetchAll: serviceLocator(),
      fetchFromCache: serviceLocator(),
    ),
  );
}
