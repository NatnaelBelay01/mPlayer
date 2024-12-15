import 'package:mplayer/features/music_player/data/model/music_model_adapter.dart';
import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicModel extends MusicEntity {
  const MusicModel({
    super.title,
    super.artist,
    required super.path,
    super.photoByte,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "path": path,
      "artist": artist,
    };
  }

  MusicModelAdapter toAdapter() {
    return MusicModelAdapter(
        title: title, artist: artist, path: path, photoByte: photoByte);
  }

  factory MusicModel.fromJson(Map<dynamic, dynamic> json) {
    return MusicModel(
      title: json["title"],
      path: json["path"],
      artist: json["artist"],
    );
  }
}
