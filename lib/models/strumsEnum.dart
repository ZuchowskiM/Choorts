
import 'package:hive/hive.dart';

part 'strumsEnum.g.dart';


@HiveType(typeId: 2)
enum Strum{

  @HiveField(0)
  up,

  @HiveField(1)
  down,

  @HiveField(2)
  pause,
}