// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progressionModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressionModelAdapter extends TypeAdapter<ProgressionModel> {
  @override
  final int typeId = 1;

  @override
  ProgressionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressionModel(
      fields[0] as String,
      fields[1] as bool,
    )
      ..chords = (fields[2] as List).cast<String>()
      ..tabImage = fields[31] as Uint8List;
  }

  @override
  void write(BinaryWriter writer, ProgressionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isChordsProgression)
      ..writeByte(2)
      ..write(obj.chords)
      ..writeByte(31)
      ..write(obj.tabImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
