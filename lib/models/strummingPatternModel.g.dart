// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strummingPatternModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StrummingPatternModelAdapter extends TypeAdapter<StrummingPatternModel> {
  @override
  final int typeId = 3;

  @override
  StrummingPatternModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StrummingPatternModel(
      fields[0] as String,
      (fields[2] as List).cast<bool>(),
      (fields[3] as List).cast<bool>(),
    )..strums = (fields[1] as List).cast<Strum>();
  }

  @override
  void write(BinaryWriter writer, StrummingPatternModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.strums)
      ..writeByte(2)
      ..write(obj.isStrumUp)
      ..writeByte(3)
      ..write(obj.isStrumDown);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StrummingPatternModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
