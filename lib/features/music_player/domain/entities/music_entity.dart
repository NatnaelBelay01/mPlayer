import 'dart:typed_data';

class MusicEntity {
  final String title;
  final String path;
  final String artist;
  final Uint8List? photoByte;

  const MusicEntity({
    this.title = "unknown",
    this.path = "unknown",
    this.artist = "unknown",
    this.photoByte,
  });
}
