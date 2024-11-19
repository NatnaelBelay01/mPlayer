import 'package:fpdart/fpdart.dart';
import 'package:mplayer/core/error/failure.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/domain/repository/repository.dart';

class FetchAll {
  final MusicRepository repository;

  const FetchAll({required this.repository});

  Future<Either<Failure, List<MusicEntity>>> call() async {
    return await repository.fetchAllMusic();
  }
}
