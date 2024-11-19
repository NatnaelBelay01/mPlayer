import 'package:fpdart/fpdart.dart';
import 'package:mplayer/core/error/failure.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

abstract interface class MusicRepository{
	Future<Either<Failure, List<MusicEntity>>> fetchAllMusic();
	MusicEntity nextTrack();
	MusicEntity previousTrack();
}
