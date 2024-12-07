import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicControlEvent {}

class LoadPlaylistEvent extends MusicControlEvent {
  final List<MusicEntity> musicList;
  LoadPlaylistEvent({required this.musicList});
}

class PlayingEvent extends MusicControlEvent {
  final MusicEntity? nowPlaying;

  PlayingEvent({this.nowPlaying});
}

class PlayEvent extends MusicControlEvent {
	final MusicEntity? musicEntity;
	PlayEvent({this.musicEntity});
}

class PauseEvent extends MusicControlEvent {
  final MusicEntity? onPause;

  PauseEvent({required this.onPause});
}

class NextEvent extends MusicControlEvent {}

class PreviousEvent extends MusicControlEvent {}

class PlayThisEvent extends MusicControlEvent {
  final MusicEntity musicEntity;

  PlayThisEvent({required this.musicEntity});
}
