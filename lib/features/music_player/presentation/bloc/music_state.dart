import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicState {}

class MusicLoadingState extends MusicState{}

class MusicInitialState extends MusicState {}
class LoadSuccess extends MusicState{
	final List<MusicEntity> result;
	LoadSuccess({required this.result});
}
class MusicLoadStorageSuccess extends LoadSuccess {

  MusicLoadStorageSuccess({required super.result});
}

class MusicLoadCacheSuccess extends LoadSuccess {

  MusicLoadCacheSuccess({required super.result});
}

class StorageLoadingFailure extends LoadingFailure {
  StorageLoadingFailure({
    super.message = "something went wrong while loading from cache",
  });
}

class CacheLoadingFailure extends LoadingFailure {
  CacheLoadingFailure(
      {super.message = "something went wrong while loading from cache"});
}

class LoadingFailure extends MusicState {
  final String message;

  LoadingFailure({this.message = "something went wrong"});
}

class PlayingState extends MusicState{
	final MusicEntity nowPlaying;

	PlayingState({required this.nowPlaying});
}

class PauseState extends MusicState{
	final MusicEntity onPause;

	PauseState({required this.onPause});
}


class NextState extends MusicState{}
class PreviousState extends MusicState{}
