import 'package:choorts/models/progressionModel.dart';
import 'package:choorts/models/strummingPatternModel.dart';
import 'package:hive/hive.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song {

  @HiveField(0)
  String name;

  @HiveField(1)
  String autor;

  @HiveField(2)
  double tempo = 80;

  @HiveField(3)
  List<ProgressionModel> progressions = [];

  @HiveField(4)
  List<StrummingPatternModel> strummingPatterns = [];
  
  Song(this.name,this.autor);

}