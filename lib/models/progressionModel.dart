
import 'package:flutter/services.dart';
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

  @HiveField(3)
  ByteData tabImage = ByteData(10);


  ProgressionModel(this.name, this.isChordsProgression);


}