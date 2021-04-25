
import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'progressionModel.g.dart';

@HiveType(typeId: 1)
class ProgressionModel{

  @HiveField(0)
  String name;

  @HiveField(1)
  bool isChordsProgression;

  @HiveField(2)
  List<String> chords = [];

  @HiveField(31)
  Uint8List tabImage = Uint8List(10);


  ProgressionModel(this.name, this.isChordsProgression);


}