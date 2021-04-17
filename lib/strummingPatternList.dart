import 'package:choorts/strummingPattern.dart';
import 'package:flutter/material.dart';

class StrummingPatternList extends StatelessWidget {

  final List<StrummingPattern> strummingPattern;

  StrummingPatternList({Key? key, required this.strummingPattern}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: strummingPattern.length,
      itemBuilder: (BuildContext context, int index){
        return //Column(
          //children: [
            //Wrap(children:[
              strummingPattern[index];
            //] ),
            //Divider(),
          //],);
      },
    );
  }
}