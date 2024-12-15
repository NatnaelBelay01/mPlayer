import 'dart:io';
import 'dart:typed_data';
import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplayer/core/error/exception.dart';
import 'package:mplayer/core/utils/request_permission.dart';
import 'package:mplayer/features/music_player/data/model/music_model.dart';
import 'package:mplayer/features/music_player/data/model/music_model_adapter.dart';

abstract interface class LocalDataSource {
  Future<List<MusicModel>> fetchAll();
  List<MusicModel> fetchFromCache();
  void cacheAll(List<MusicModel> musicList);
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box box;
  LocalDataSourceImpl({required this.box});

  @override
  void cacheAll(List<MusicModel> musicList) {
    box.clear();
    for (var i = 0; i < musicList.length; i++) {
      box.put(i.toString(), musicList[i].toAdapter());
    }
  }

  @override
  Future<List<MusicModel>> fetchAll() async {
    await requestPermissions();
    List<FileSystemEntity> allFiles = [];
    Directory dir = Directory("/storage/emulated/0/");
    await parseRecursively(dir, allFiles);
    List<MusicModel> allMusics = [];
    for (int i = 0; i < allFiles.length; i++) {
      var temp = await extractModel(allFiles[i]);
      if (temp != null) {
        allMusics.add(temp);
      }
    }
    return allMusics;
  }

  @override
  List<MusicModel> fetchFromCache() {
    try{
    final List<MusicModel> allMusic = box.values
        .map((musicAdapt) => (musicAdapt as MusicModelAdapter).toMusicModel())
        .toList()
      ..sort((a, b) => a.title.compareTo(b.title));
    return allMusic;
    } catch(e){
      throw LoadingException(message: e.toString());
    }
  }

  Future<void> parseRecursively(
      Directory dir, List<FileSystemEntity> files) async {
    final List excludedFolder = [
      'Android',
      'data',
      'obb',
      'system',
      'root',
      'proc',
      'sys',
      'dev',
      'tmp',
      '.thumbnails',
      '.cache',
      'backups',
    ];
    try {
      await for (var entity in dir.list(recursive: false, followLinks: false)) {
        if (entity is Directory) {
          final dirName = entity.path.split('/').last.toLowerCase();
          if (excludedFolder.contains(dirName)) continue;
          await parseRecursively(entity, files); // Await recursive calls
        } else if (entity is File) {
          if ((entity.path.endsWith('.m4a') ||
                  entity.path.endsWith('.opus') ||
                  entity.path.endsWith('.mp3')) &&
              (await entity.length()) >= 1048576) {
            files.add(entity);
          }
        }
      }
    } catch (e) {
      throw LoadingException(message: e.toString());
    }
  }

  Future<MusicModel?> extractModel(FileSystemEntity file) async {
    try {
      final tagger = Audiotagger();
      Tag? tag = await tagger.readTags(path: file.path);

      if (tag != null) {
        Uint8List? imageByte = await tagger.readArtwork(path: file.path);
        return MusicModel(
            path: file.path,
            artist: tag.artist ?? "Unknown",
            title: tag.title ?? "UnKnown",
            photoByte: imageByte,
            );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
