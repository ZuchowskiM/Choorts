
import 'package:flutter/services.dart';

class ProgressionModel{

  String name;

  bool isChordsProgression;
  List<String> chords = [];
  ByteData tabImage = ByteData(10);


  ProgressionModel(this.name, this.isChordsProgression);


}