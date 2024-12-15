// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicModelAdapterAdapter extends TypeAdapter<MusicModelAdapter> {
  @override
  final int typeId = 0;

  @override
  MusicModelAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicModelAdapter(
      title: fields[0] as String,
      artist: fields[1] as String,
      path: fields[2] as String,
      photoByte: fields[3] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, MusicModelAdapter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.photoByte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicModelAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
