import 'package:flutter/material.dart';

class StrummingPattern extends StatelessWidget {

  final List<bool> isStrumUp;
  final List<bool> isStrumDown;
  final String patternName;

  List<Widget> strums = [];
  List<Text> strumsNumerators = [];
  

  StrummingPattern({Key? key, required this.isStrumUp, required this.isStrumDown,required this.patternName})
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text(patternName, textAlign: TextAlign.center, style: TextStyle(
          fontSize: 20,
        ),),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            height: 50,
            child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: isStrumUp.length,
            itemBuilder: (BuildContext context, int index){

              if(isStrumUp[index]){
                return Column(
                  children: [
                    Icon(Icons.arrow_upward),
                    Text(index.toString()),
                  ],
                );
              }
              else if(isStrumDown[index]){
              return Column(
                children: [
                  Icon(Icons.arrow_downward),
                  Text(index.toString()),
                ],
              );
              }
              else{
                return Column(
                  children: [
                    Opacity(opacity: 0.0, child: Icon(Icons.arrow_upward)),
                    Text(index.toString()),
                  ],
                );
              }

            }),
          )
        ]),
        Divider(),
      ],);
  }

  void buildStrumsList(){

    for (var i = 0; i < isStrumUp.length; i++) {

      if(isStrumUp[i]){
        strums.add(Icon(Icons.arrow_upward));
      }
      else if(isStrumDown[i]){
        strums.add(Icon(Icons.arrow_downward));
      }
      else{
        strums.add(VerticalDivider());
      }
      
    }

  }




}