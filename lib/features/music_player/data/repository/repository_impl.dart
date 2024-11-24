import 'package:fpdart/fpdart.dart';
import 'package:mplayer/core/error/failure.dart';
import 'package:mplayer/features/music_player/data/datasources/local_data_source.dart';
import 'package:mplayer/features/music_player/data/model/music_model.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/domain/repository/repository.dart';

class RepositoryImpl implements MusicRepository {
  final LocalDataSource localDataSource;
  const RepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<MusicEntity>>> fetchAllMusic() async {
    try {
      List<MusicModel> musicList = [];
      musicList = await localDataSource.fetchAll();
			localDataSource.cacheAll(musicList);
      return right(musicList);
    } catch (e) {
      return left(const Failure(message: "something went wrong while fetching"));
    }
  }

  @override
  MusicEntity nextTrack() {
    // TODO: implement nextTrack
    throw UnimplementedError();
  }

  @override
  MusicEntity previousTrack() {
    // TODO: implement previousTrack
    throw UnimplementedError();
  }
}
