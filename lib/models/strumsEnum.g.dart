// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strumsEnum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StrumAdapter extends TypeAdapter<Strum> {
  @override
  final int typeId = 2;

  @override
  Strum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Strum.up;
      case 1:
        return Strum.down;
      case 2:
        return Strum.pause;
      default:
        return Strum.up;
    }
  }

  @override
  void write(BinaryWriter writer, Strum obj) {
    switch (obj) {
      case Strum.up:
        writer.writeByte(0);
        break;
      case Strum.down:
        writer.writeByte(1);
        break;
      case Strum.pause:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StrumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
