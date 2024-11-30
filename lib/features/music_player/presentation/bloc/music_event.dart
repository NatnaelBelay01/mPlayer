import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicEvent {}

class MusicFetchFromStorage extends MusicEvent {}

class MusicFetchFromCache extends MusicEvent {}

class PlayingEvent extends MusicEvent {
  final MusicEntity nowPlaying;

  PlayingEvent({required this.nowPlaying});
}
class PlayEvent extends MusicEvent{

}
class PauseEvent extends MusicEvent {
  final MusicEntity onPause;

  PauseEvent({required this.onPause});
}

class NextEvent extends MusicEvent {}

class PreviousEvent extends MusicEvent {}

class PlayThisEvent extends MusicEvent{
	final MusicEntity musicEntity;

	PlayThisEvent({required this.musicEntity});
}
