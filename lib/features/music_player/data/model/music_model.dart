import 'package:mplayer/features/music_player/domain/entities/music_entity.dart';

class MusicModel extends MusicEntity {
  const MusicModel({
    super.title,
    super.artist,
    required super.path,
  });

  Map<String, dynamic> toJson(MusicModel model) {
    return {
      "title": title,
      "path": path,
      "artist": artist,
    };
  }

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      title: json["title"],
      path: json["path"],
      artist: json["artist"],
    );
  }
}
