import 'package:choorts/strummingPattern.dart';
import 'package:flutter/material.dart';
import 'models/strummingPatternModel.dart';

class StrummingPatternList extends StatefulWidget {

  final List<StrummingPatternModel> strummingPattern;

  StrummingPatternList({Key? key, required this.strummingPattern}): super(key: key);

  @override
  _StrummingPatternListState createState() => _StrummingPatternListState();
}

class _StrummingPatternListState extends State<StrummingPatternList> {
  deleteStrummingPattern(BuildContext context, int index){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Delete strumming pattern?", textAlign: TextAlign.center,),
        actions: <Widget>[
          Center(child: MaterialButton(
            child: Text("Confirm"),
            color: Colors.red,
            onPressed: (){
              setState(() {
                widget.strummingPattern.removeAt(index);
                Navigator.of(context).pop();
              });
          })
          ),
        ],
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.strummingPattern.length,
      itemBuilder: (BuildContext context, int index){
        return 
          Column(
            children: [
              StrummingPattern(
                patternName: widget.strummingPattern[index].name ,
                strums: widget.strummingPattern[index].strums),
              
              IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: (){
                deleteStrummingPattern(context, index);
              }),
              Divider(),
            ],
          );
           
      },
    );
  }
}