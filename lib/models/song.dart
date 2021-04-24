import 'package:choorts/models/progressionModel.dart';
import 'package:choorts/models/strummingPatternModel.dart';

class Song {

  String name;
  String autor;
  double tempo = 80;
  List<ProgressionModel> progressions = [];
  List<StrummingPatternModel> strummingPatterns = [];
  
  Song(this.name,this.autor);

}