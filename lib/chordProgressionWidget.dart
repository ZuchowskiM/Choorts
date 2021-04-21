import 'package:flutter/material.dart';

class ChordProgressionWidget extends StatefulWidget {

  final List<String> chords;

  ChordProgressionWidget({Key? key, required this.chords}): super(key: key);

  @override
  _ChordProgressionWidgetState createState() => _ChordProgressionWidgetState();
}

class _ChordProgressionWidgetState extends State<ChordProgressionWidget> {

  List<Widget> chordsProgression = [];
  List<String> fullChordsList = ["Am", "C", "D", "G"];
  List<String> chords = [];


  @override
  void initState(){
    
    chords = widget.chords;

    chordsProgression.add(IconButton(
      icon: Icon(Icons.add,),
      onPressed: () {
        addChord(context);
      },
    ));

    super.initState();
    
  }

  addChord(BuildContext context){

    Widget setupChordsListContainer(){
      return Container(
        height: 200.0, // Change as per your requirement
        width: 200.0, // Change as per your requirement
        child: ListView.builder(
          itemCount: fullChordsList.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text('${fullChordsList[index]}'),
              onTap: () {
                setState(() {
                  // chordsProgression.insert(chordsProgression.length - 1,
                  // Image.asset("data/images/chords/${chordsList[index]}.png"));
                  
                  chords.add('${fullChordsList[index]}');
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
      itemCount: chords.length+1,
      itemBuilder: (BuildContext context, int i) {

      if(i<chords.length){
        return Image.asset("data/images/chords/${chords[i]}.png");
      }
      else{
        //return chordsProgression[i];

        return IconButton(
          icon: Icon(Icons.add,),
          onPressed: () {
            addChord(context);
          },
        );
      }
              
    });
  }
}