import 'package:flutter/material.dart';

class strummingPattern extends StatelessWidget {

  List<bool> isStrumUp = [];
  List<bool> isStrumDown = [];
  
  List<Widget> strums = [];
  List<Text> strumsNumerators = [];
  String patternName = "main";

  strummingPattern({Key? key, required this.isStrumUp, required this.isStrumDown}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Text(patternName, textAlign: TextAlign.center,),
        Row(children: strums),
        Row(children: strumsNumerators),
      ],
    );
  }

  void buildStrumsList(){

    for (var i = 0; i < isStrumUp.length; i++) {

      if(isStrumDown[i]){
        strums.add(Icon(Icons.arrow_upward));
      }
      else {
        strums.add(Icon(Icons.arrow_downward));
      }
      
    }

  }

  void buildStrumsNumerator(){

    for (var i = 0; i < isStrumUp.length; i++) {
      strumsNumerators.add(Text((i+1).toString()));
    }

  }



}