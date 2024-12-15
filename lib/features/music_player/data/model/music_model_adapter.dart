import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:mplayer/features/music_player/data/model/music_model.dart';

part 'music_model_adapter.g.dart';

@HiveType(typeId: 0)
class MusicModelAdapter {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String artist;

  @HiveField(2)
  final String path;

  @HiveField(3)
  final Uint8List? photoByte;

  MusicModelAdapter({
    required this.title,
    required this.artist,
    required this.path,
    required this.photoByte,
  });

  MusicModel toMusicModel(){
    return MusicModel(title: title, path: path, artist: artist, photoByte: photoByte);
  }
}
