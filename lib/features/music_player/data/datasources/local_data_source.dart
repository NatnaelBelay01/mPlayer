import 'dart:io';
import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:mplayer/core/error/exception.dart';
import 'package:mplayer/features/music_player/data/model/music_model.dart';

abstract interface class LocalDataSource {
  Future<List<MusicModel>> fetchAll();
  List<MusicModel> fetchFromCache();
  void cacheAll();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  void cacheAll() {
    // TODO: implement cacheAll
  }

  @override
  Future<List<MusicModel>> fetchAll() async {
    List<FileSystemEntity> allFiles = [];
    Directory dir = Directory("/storage/emulated/0/");
    parseRecursively(dir, allFiles);
  }

  @override
  List<MusicModel> fetchFromCache() {
    // TODO: implement fetchFromCache
    throw UnimplementedError();
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

	Future<MusicModel> extractModel(File file) async {
		final tagger = Audiotagger();
		Tag? tag = await tagger.readTags(path: file.path);

		if(tag != null){
			return MusicModel(path: file.path, artist: tag.artist ?? "", title: tag.title ?? "");
		} else {
			return MusicModel(path: file.path);
		}
	}
}
