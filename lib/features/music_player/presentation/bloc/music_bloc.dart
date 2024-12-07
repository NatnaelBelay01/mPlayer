import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_all.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_from_cache.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_event.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final FetchAll fetchAll;
  final FetchFromCache fetchFromCache;
  final AudioPlayer player;

  Map<int, MusicEntity> _musicEntities = {};
  Map<MusicEntity, int> _indexMap = {};

  MusicBloc({
    required this.fetchAll,
    required this.fetchFromCache,
    required this.player,
  }) : super(MusicInitialState()) {
    on<MusicFetchFromStorage>((event, emit) async {
      emit(MusicLoadingState());
      final result = await fetchAll();
      result.fold(
        (fail) => emit(StorageLoadingFailure(message: fail.message)),
        (musicList) {
          emit(MusicLoadStorageSuccess(result: musicList));
          _initializePlaylist(musicList);
        },
      );
    });
    on<MusicFetchFromCache>((event, emit) async {
      final result = await fetchFromCache();
      result.fold(
        (fail) => emit(CacheLoadingFailure(message: fail.message)),
        (musicList) {
          emit(MusicLoadCacheSuccess(result: musicList));
          _initializePlaylist(musicList);
        },
      );
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
