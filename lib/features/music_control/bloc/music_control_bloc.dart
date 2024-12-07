import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mplayer/features/music_control/bloc/music_control_event.dart';
import 'package:mplayer/features/music_control/bloc/music_control_state.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicControlBloc extends Bloc<MusicControlEvent, MusicControlState> {
  final AudioPlayer player;
  Map<int, MusicEntity> _musicEntities = {};
  Map<MusicEntity, int> _indexMap = {};

  MusicControlBloc({required this.player}) : super(MusicControlIntialState()) {
    on<LoadPlaylistEvent>((event, emit) {
      _initializePlaylist(event.musicList);
    });
    on<PlayingEvent>((event, emit) {
      final nowPlayingTrack = event.nowPlaying;
      emit(PlayingState(nowPlaying: nowPlayingTrack));
    });

    on<PlayEvent>((event, emit) async {
      await player.play();
      emit(PlayingState(nowPlaying: event.musicEntity));
    });

    on<PauseEvent>((event, emit) async {
      await player.pause();
      emit(PauseState(onPause: event.onPause));
    });
    on<NextEvent>((event, emit) {
      player.seekToNext();
      emit(NextState());
    });

    on<PreviousEvent>((event, emit) {
      player.seekToPrevious();
      emit(PreviousState());
    });

    on<PlayThisEvent>((event, emit) {
      final index = _indexMap[event.musicEntity];
      if (index != null) {
        player.seek(Duration.zero, index: index);
        player.play();
        add(PlayingEvent(nowPlaying: event.musicEntity));
      } else {
        emit(PlayingFailure(message: "Music not found"));
      }
    });

    player.currentIndexStream.listen((index) {
      if (index != null && player.audioSource is ConcatenatingAudioSource) {
        add(PlayingEvent(nowPlaying: _musicEntities[index]!));
      }
    });

    player.playerStateStream.listen((playerState) {
      if (playerState.playing) {
        if (state is PauseState) {
          final pausedTrack = (state as PauseState).onPause;
          add(PlayEvent(musicEntity: pausedTrack));
        }
      } else {
        if (state is PlayingState) {
          final currentTrack = (state as PlayingState).nowPlaying;
          add(PauseEvent(onPause: currentTrack));
        }
      }
    });

  }
  void _initializePlaylist(List<MusicEntity> musicList) {
    ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: musicList
          .map(
            (music) => AudioSource.file(
              music.path,
            ),
          )
          .toList(),
    );
    player.setAudioSource(
      playlist,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
    _musicEntities = {};
    _indexMap = {};
    for (int i = 0; i < musicList.length; i++) {
      _musicEntities[i] = musicList[i];
      _indexMap[musicList[i]] = i;
    }
  }
}
