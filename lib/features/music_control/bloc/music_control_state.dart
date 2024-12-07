import '../../music_player/domain/entities/music_entity.dart';

class MusicControlState {}

class MusicControlIntialState extends MusicControlState {}

class PlayingState extends MusicControlState {
  final MusicEntity? nowPlaying;

  PlayingState({this.nowPlaying});
}

class PauseState extends MusicControlState {
  final MusicEntity? onPause;

  PauseState({required this.onPause});
}

class NextState extends MusicControlState {}

class PreviousState extends MusicControlState {}

class PlayingFailure extends MusicControlState{
	final String message;

	PlayingFailure({this.message = "an Unexpected Error has occured"});
}
