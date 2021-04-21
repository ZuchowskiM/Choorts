
import 'package:choorts/models/strumsEnum.dart';

class StrummingPatternModel{

  String name;
  List<Strum> strums = [];
  final List<bool> isStrumUp;
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