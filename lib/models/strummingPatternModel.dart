
import 'package:choorts/models/strumsEnum.dart';
import 'package:hive/hive.dart';

part 'strummingPatternModel.g.dart';

@HiveType(typeId: 3)
class StrummingPatternModel{

  @HiveField(0)
  String name;

  @HiveField(1)
  List<Strum> strums = [];

  @HiveField(2)
  final List<bool> isStrumUp;

  @HiveField(3)
  final List<bool> isStrumDown;

  StrummingPatternModel(this.name, this.isStrumUp, this.isStrumDown){

    for(int i=0; i<isStrumUp.length; i++){

      if(isStrumUp[i]){
        strums.add(Strum.up);
      }
      else if(isStrumDown[i])
      {
        strums.add(Strum.down);
      }
      else{
        strums.add(Strum.pause);
      }

    }
    
  }

}