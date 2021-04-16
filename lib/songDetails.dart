import 'dart:ui';
import 'package:choorts/strummingCheckBoxList.dart';
import 'package:flutter/material.dart';

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey = GlobalKey();

  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}

class SongDetails extends StatefulWidget {
  @override
  _SongDetailsState createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {

  double _currentTempoValue = 120;
  bool _isTempoSliderVisible = false;
  var chordsProgression = <Widget>[];
  List<String> chordsList = ["Am", "C", "D", "G"];
  List<List<Widget>> progressions = [];
  List<String> progressionsTitles = [];
  
  void showTempoSlider() {
    setState(() {
      _isTempoSliderVisible = !_isTempoSliderVisible;
    });
  }

  addChord(BuildContext context, int progresionPos){

    TextEditingController customController  =  new TextEditingController();

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
                  progressions[progresionPos].insert(progressions[progresionPos].length - 1,
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

  showAddStrummingDialog(BuildContext context) {

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Add strumming",
        textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            strummingCheckBoxList(isStrummingUp: true,),
            strummingCheckBoxList(isStrummingUp: false,),           
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(child: Icon(Icons.music_note), width: 35, alignment: Alignment.centerLeft,),
                Expanded(child: Text("1")),
                Expanded(child: Text("&")),
                Expanded(child: Text("2")),
                Expanded(child: Text("&")),
                Expanded(child: Text("3")),
                Expanded(child: Text("&")),
                Expanded(child: Text("4")),
                Expanded(child: Text("&")),
              ],
            )
          ],
          ),
        actions: <Widget>[
          Center(
            child: MaterialButton(
              onPressed: (){}, 
              color: Colors.blue,
              elevation: 0.5,
              child: Text("Add",
              style: TextStyle(
              fontSize: 20,
              color: Colors.white),
              ),),
          )
        ],
      );
    });

  }

  showAddProgressionDialog(BuildContext context){

    TextEditingController customController  =  new TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Choose progression",
        textAlign: TextAlign.center),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

                MaterialButton(
                  color: Colors.blue,
                  elevation: 0.5,
                  child: Text("Chords",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white),
                      ),
                  onPressed: (){
                    setState(() {
                      List<Widget> temp = [];

                      int i = progressions.length;

                      temp.add(
                        IconButton(
                        icon: Icon(Icons.add,),
                        onPressed: () {
                          addChord(myGlobals.scaffoldKey.currentContext!, i);
                        },
                      ));

                      progressions.add(temp);
                      progressionsTitles.add(customController.text.toString());
                      Navigator.of(context).pop(customController.text.toString());
                    });
                  }
                ),
              MaterialButton(
                color: Colors.blue,
                  elevation: 0.5,
                  child: Text("Tab",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white),
                      ),
                  onPressed: (){
                    
                  }
              ,)
            ]
          )
          )
          
        ],
      );
    });
    
  }

  getProgressionsList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: progressions.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(children: [
          
          Text(progressionsTitles[index], textAlign: TextAlign.center,),
          Wrap(children: [
            GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
            itemCount: progressions[index].length,
            itemBuilder: (BuildContext context, int i) {

              if(i==progressions[index].length){
                return Image.asset("data/images/chords/${progressions[index][i]}.png");
              }
              else{
                return progressions[index][i];
              }
              
            })
          ]),
          Divider(),
        ],);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myGlobals._scaffoldKey,
      appBar: AppBar (
        title: Text("Choorts"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Center(
          child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Tempo: ${_currentTempoValue.round().toString()}",
                style: TextStyle(fontSize: 20),
                ),
                FloatingActionButton(onPressed: () {
                  showTempoSlider();
              },
              child: Icon(Icons.add),
              ),
              ],
            ),
            Row(children: [
              Visibility(
                visible: _isTempoSliderVisible,
                child: Expanded(
                  child: Slider(
                    value: _currentTempoValue,
                    min:1,
                    max:200,
                    label: _currentTempoValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentTempoValue = value;
                      });
                    },
                  )
                )
              )
            ],),
            Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Strumming patterns:",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],),
            SizedBox(height: 30),
            Row( children: [
              FloatingActionButton(onPressed: () {
                showAddStrummingDialog(context);
              },
              child: Icon(Icons.add)),
            ],),
             Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Progression",
              style: TextStyle(fontSize: 20))
            ],),
            SizedBox(height: 30),
            getProgressionsList(),
            SizedBox(height: 30),
            Row(children: [
              FloatingActionButton(onPressed: () {
                showAddProgressionDialog(context);
              },
              child: Icon(Icons.add)),
            ],)
          ] ,
        ),
    ),
    ),
    ),   
    );
    
    
    
    
  }
}