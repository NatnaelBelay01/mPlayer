import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicState {}

class MusicLoadingState {}

class MusicInitialState extends MusicState {}

class MusicLoadStorageSuccess extends MusicState {
  final List<MusicEntity> result;

  MusicLoadStorageSuccess({required this.result});
}

class MusicLoadCacheSuccess extends MusicState {
  final List<MusicEntity> result;

  MusicLoadCacheSuccess({required this.result});
}

class LoadingFailure extends MusicState {
  final String message;

  LoadingFailure({this.message = "something went wrong"});
}
