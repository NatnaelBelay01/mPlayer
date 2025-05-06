import 'package:just_audio/just_audio.dart';

import '../../music_player/domain/entities/music_entity.dart';

class MusicControlState {}

class MusicControlIntialState extends MusicControlState {}

class PlayingState extends MusicControlState {
  final MusicEntity? nowPlaying;
  final AudioPlayer player;

  PlayingState({this.nowPlaying, required this.player});
}

class PauseState extends MusicControlState {
  final MusicEntity? onPause;

  PauseState({required this.onPause});
}

class NextState extends MusicControlState {}

class PreviousState extends MusicControlState {}

class PlayingFailure extends MusicControlState {
  final String message;

  PlayingFailure({this.message = "an Unexpected Error has occured"});
}

class PlaylistLoadSuccess extends MusicControlState {
  final AudioPlayer player;
  PlaylistLoadSuccess({required this.player});
}
