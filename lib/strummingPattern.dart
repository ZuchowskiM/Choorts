import 'package:choorts/models/strumsEnum.dart';
import 'package:flutter/material.dart';

class StrummingPattern extends StatelessWidget {

  final String patternName;
  final List<Strum> strums;
  

  StrummingPattern({Key? key, required this.patternName, required this.strums})
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
            itemCount: strums.length,
            itemBuilder: (BuildContext context, int index){

              if(strums[index] == Strum.up){
                return Column(
                  children: [
                    Icon(Icons.arrow_upward),
                    Text(index.toString()),
                  ],
                );
              }
              else if(strums[index] == Strum.down){
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
      ],);
  }

}