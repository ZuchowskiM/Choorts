// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      fields[0] as String,
      fields[1] as String,
    )
      ..tempo = fields[2] as double
      ..progressions = (fields[3] as List).cast<ProgressionModel>()
      ..strummingPatterns = (fields[4] as List).cast<StrummingPatternModel>();
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.autor)
      ..writeByte(2)
      ..write(obj.tempo)
      ..writeByte(3)
      ..write(obj.progressions)
      ..writeByte(4)
      ..write(obj.strummingPatterns);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
