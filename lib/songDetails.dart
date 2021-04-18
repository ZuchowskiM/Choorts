import 'dart:ui';
import 'package:choorts/strummingCheckBoxList.dart';
import 'package:choorts/strummingPattern.dart';
import 'package:choorts/strummingPatternList.dart';
import 'package:choorts/tabCharsGrid.dart';
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
  List<StrummingPattern> strummingPatterns = [];
  
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

  showAddTabDialog(BuildContext context){

    TextEditingController customController  =  new TextEditingController();
    bool accepted = true;
    Text example = Text("default");
    double x = 200;
    double y = 20;
    double wantedX = 200;
    double wantedY = 20;

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Add tab",
          textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: DragTarget<Text>(
                builder: (context, candidateData, rejectedData) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTapUp: (details) {
                      setState(() {
                        wantedX = details.localPosition.dx;
                        wantedY = details.localPosition.dy;
                        print(wantedY);
                        print(wantedX);
                      });
                      
                    },
                    child: Stack(
                      children: [
                        Positioned(top: wantedY, left: wantedX, child: example,),
                        Image.asset("data/images/other/tab.png")]),
                  );
                },
                onWillAccept: (data) {
                  return accepted;
                },
                // onAccept: (data) {
                //   setState(() {
                //     print("acceptowano");
                //     example = data;
                //   });
                  
                // },
                onAcceptWithDetails: (details) {
                  setState(() {
                    print("acceptowano");
                    //x = details.offset.dx;
                    //y = details.offset.dy;
                    example = details.data;
                  });
                },
                onLeave: (data) {
                  print("leave");
                },
                
              )
            ),
            Row(
              children: [
                Expanded(child: Container(height: 400, width: 200, child: TabCharsGrid())),
              ],
            ),
          ]
        ),
      );
    });
  }

  showAddStrummingDialog(BuildContext context) {

    TextEditingController customController  =  new TextEditingController();
    StrummingCheckBoxList strummingCheckBoxListUp = new StrummingCheckBoxList(isStrummingUp: true);
    StrummingCheckBoxList strummingCheckBoxListDown = new StrummingCheckBoxList(isStrummingUp: false);

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Add strumming",
          textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: customController,),
            strummingCheckBoxListUp,
            strummingCheckBoxListDown,           
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
              onPressed: (){
                setState(() {
                  String tempPatternName = customController.text.toString();

                  if(tempPatternName == "") {tempPatternName="Main";}

                  StrummingPattern temp = StrummingPattern(isStrumUp: strummingCheckBoxListUp.boxState,
                  isStrumDown: strummingCheckBoxListDown.boxState,
                  patternName: tempPatternName,);

                  strummingPatterns.add(temp);
                });
              }, 
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
                    setState(() {
                      showAddTabDialog(context);
                    });
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
            StrummingPatternList(strummingPattern: strummingPatterns),
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