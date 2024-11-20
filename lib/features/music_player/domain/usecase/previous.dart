import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/domain/repository/repository.dart';

class Previous {
	final MusicRepository repository;

	const Previous({required this.repository});
	
	MusicEntity call(){
		return repository.previousTrack();
	}
}
