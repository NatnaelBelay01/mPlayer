import 'dart:io';
import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:hive/hive.dart';
import 'package:mplayer/core/error/exception.dart';
import 'package:mplayer/core/utils/request_permission.dart';
import 'package:mplayer/features/music_player/data/model/music_model.dart';

abstract interface class LocalDataSource {
  Future<List<MusicModel>> fetchAll();
  List<MusicModel> fetchFromCache();
  void cacheAll(List<MusicModel> musicList);
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box box;
  const LocalDataSourceImpl({required this.box});

  @override
  void cacheAll(List<MusicModel> musicList) {
    box.clear();
    box.write(() {
      for (var i = 0; i < musicList.length; i++) {
        box.put(i.toString(), musicList[i].toJson());
      }
    });
  }

  @override
  Future<List<MusicModel>> fetchAll() async {
    await requestPermissions();
    List<FileSystemEntity> allFiles = [];
    Directory dir = Directory("/storage/emulated/0/");
    await parseRecursively(dir, allFiles);
    List<MusicModel> musicList =
        await Future.wait(allFiles.map((file) => extractModel(file)).toList());
    musicList.sort((a, b) => a.title.compareTo(b.title));
    return musicList;
  }

  @override
  List<MusicModel> fetchFromCache() {
    final List<MusicModel> allMusic = [];
    box.read(() {
      for (var i = 0; i < box.length; i++) {
        allMusic.add(MusicModel.fromJson(box.get(i.toString())));
      }
    });
    allMusic.sort((a, b) => a.title.compareTo(b.title));
    return allMusic;
  }

  Future<void> parseRecursively(
      Directory dir, List<FileSystemEntity> files) async {
    try {
      await for (var entity in dir.list(recursive: false, followLinks: false)) {
        if (entity is Directory) {
          if (entity.path.contains('/Android/')) continue;
          await parseRecursively(entity, files); // Await recursive calls
        } else if (entity is File) {
          if (entity.path.endsWith('m4a') ||
              entity.path.endsWith('opus') ||
              entity.path.endsWith('mp3')) {
            files.add(entity);
          }
        }
      }
    } catch (e) {
      throw LoadingException(message: e.toString());
    }
  }

  Future<MusicModel> extractModel(FileSystemEntity file) async {
    try {
      final tagger = Audiotagger();
      Tag? tag = await tagger.readTags(path: file.path);

      if (tag != null) {
        return MusicModel(
            path: file.path,
            artist: tag.artist ?? "Unknown",
            title: tag.title ?? "UnKnown");
      } else {
        return MusicModel(path: file.path);
      }
    } catch (e) {
      return MusicModel(path: file.path);
    }
  }
}
