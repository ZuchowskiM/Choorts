import 'package:choorts/strummingPattern.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/song.dart';

class StrummingPatternList extends StatefulWidget {

  final Box<dynamic> songsBox;
  final int songIndex;
  final Song song;

  StrummingPatternList({Key? key, required this.songsBox,
  required this.songIndex, required this.song}): super(key: key);

  @override
  _StrummingPatternListState createState() => _StrummingPatternListState();
}

class _StrummingPatternListState extends State<StrummingPatternList> {
  deleteStrummingPattern(BuildContext context, int index){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Delete strumming pattern?", textAlign: TextAlign.center,),
        actions: <Widget>[
          Center(child: TextButton(
            child: Text("Confirm", style: TextStyle(fontSize: 20, color: Colors.red),),
            onPressed: (){
              setState(() {
                widget.song.strummingPatterns.removeAt(index);
                widget.songsBox.putAt(widget.songIndex, widget.song);
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
      itemCount: widget.song.strummingPatterns.length,
      itemBuilder: (BuildContext context, int index){
        return 
          Column(
            children: [
              StrummingPattern(
                patternName: widget.song.strummingPatterns[index].name ,
                strums: widget.song.strummingPatterns[index].strums),
              
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