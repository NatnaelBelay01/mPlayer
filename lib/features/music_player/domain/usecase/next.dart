import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';
import 'package:mplayer/features/music_player/domain/repository/repository.dart';

class Next {
	final MusicRepository repository;

	const Next({required this.repository});
	
	MusicEntity call(){
		return repository.nextTrack();
	}
}
