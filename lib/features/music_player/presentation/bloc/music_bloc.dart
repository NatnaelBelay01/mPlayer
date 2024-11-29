import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_all.dart';
import 'package:mplayer/features/music_player/domain/usecase/fetch_from_cache.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_event.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final FetchAll fetchAll;
  final FetchFromCache fetchFromCache;

  MusicBloc({
    required this.fetchAll,
    required this.fetchFromCache,
  }) : super(MusicInitialState()) {
    on<MusicFetchFromStorage>((event, emit) async {
			emit(MusicLoadingState());
      final result = await fetchAll();
      result.fold(
        (fail) => emit(StorageLoadingFailure(message: fail.message)),
        (musicList) => emit(MusicLoadStorageSuccess(result: musicList)),
      );
    });
    on<MusicFetchFromCache>((event, emit) async {
      final result = await fetchFromCache();
      result.fold(
        (fail) => emit(CacheLoadingFailure(message: fail.message)),
        (musicList) => emit(MusicLoadCacheSuccess(result: musicList)),
      );
    });
  }
}
