import 'package:choorts/strummingPattern.dart';
import 'package:flutter/material.dart';
import 'models/strummingPatternModel.dart';

class StrummingPatternList extends StatelessWidget {

  final List<StrummingPatternModel> strummingPattern;

  StrummingPatternList({Key? key, required this.strummingPattern}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: strummingPattern.length,
      itemBuilder: (BuildContext context, int index){
        return 
          StrummingPattern(patternName: strummingPattern[index].name ,strums: strummingPattern[index].strums);
           
      },
    );
  }
}