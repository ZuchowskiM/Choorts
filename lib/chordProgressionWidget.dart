import 'package:flutter/material.dart';

class ChordProgressionWidget extends StatefulWidget {

  @override
  _ChordProgressionWidgetState createState() => _ChordProgressionWidgetState();
}

class _ChordProgressionWidgetState extends State<ChordProgressionWidget> {

  List<Widget> chordsProgression = [];
  List<String> chordsList = ["Am", "C", "D", "G"];


  @override
  void initState(){
    super.initState();

    chordsProgression.add(IconButton(
      icon: Icon(Icons.add,),
      onPressed: () {
        addChord(context);
      },
    ));
    
  }

  addChord(BuildContext context){

    Widget setupChordsListContainer(){
      return Container(
        height: 200.0, // Change as per your requirement
        width: 200.0, // Change as per your requirement
        child: ListView.builder(
          itemCount: chordsList.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text('${chordsList[index]}'),
              onTap: () {
                setState(() {
                  chordsProgression.insert(chordsProgression.length - 1,
                  Image.asset("data/images/chords/${chordsList[index]}.png"));
                });
              },
            );
        }),
      );
    }

    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Pick a chord"),
        content: setupChordsListContainer(),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 4),
      itemCount: chordsProgression.length,
      itemBuilder: (BuildContext context, int i) {

      if(i==chordsProgression.length){
        return Image.asset("data/images/chords/${chordsList[i]}.png");
      }
      else{
        return chordsProgression[i];
      }
              
    });
  }
}