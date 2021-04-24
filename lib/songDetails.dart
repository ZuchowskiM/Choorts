import 'dart:ui';
import 'package:choorts/chordProgressionWidget.dart';
import 'package:choorts/models/chordsProgressionModel.dart';
import 'package:choorts/models/progressionModel.dart';
import 'package:choorts/models/strummingPatternModel.dart';
import 'package:choorts/models/tabProgressionModel.dart';
import 'package:choorts/strummingCheckBoxList.dart';
import 'package:choorts/strummingPatternList.dart';
import 'package:choorts/tabCharsGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/song.dart';

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey = GlobalKey();

  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}

class SongDetails extends StatefulWidget {

  final Song song;

  SongDetails({Key? key, required this.song}): super(key: key);

  @override
  _SongDetailsState createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {

  Song _song = Song("def", "def");
  double _currentTempoValue = 80;
  bool _isTempoSliderVisible = false;

  List<ProgressionModel> progressions = [];
  List<StrummingPatternModel> strummingPatterns = [];

  @override
  void initState(){
    _song = widget.song;

    _currentTempoValue = _song.tempo;
    progressions = _song.progressions;
    strummingPatterns = _song.strummingPatterns;

    super.initState();
  }
  
  void showTempoSlider() {
    setState(() {
      _isTempoSliderVisible = !_isTempoSliderVisible;
    });
  }

  showAddTabDialog(BuildContext context, String tabTitle){

    TextEditingController customController  =  new TextEditingController();
    bool accepted = true;
    Text example = Text("default", style: TextStyle(backgroundColor: Colors.white,));
    double x = 200;
    double y = 20;
    List<Positioned> notesList = [];
    Image tabImage = Image.asset("data/images/chords/Am.png");
    var src = new GlobalKey();

    takeScreenshot() async{
      RenderRepaintBoundary repaintBoundary = src.currentContext!.findRenderObject() as RenderRepaintBoundary;
      repaintBoundary.toImage();
      var image = await repaintBoundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      setState(() {
        tabImage = Image.memory(pngBytes.buffer.asUint8List());
      });
    }


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
                  return RepaintBoundary(
                    key: src,
                    child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(height: 180),
                      Image.asset("data/images/other/tab.png"),
                      ...notesList,
                    ]),
                  );
                },
                onWillAccept: (data) {
                  return accepted;
                },
                onAcceptWithDetails: (details) {
                  setState(() {
                    print("acceptowano");
                    x = details.offset.dx - 40;
                    y = details.offset.dy - 120.0;
                    print(x);
                    print(y);
                    example = details.data;
                    notesList.add(Positioned(top: y, left: x, child: example,));
                  });
                },
                onLeave: (data) {
                  print("leave");
                },  
              )
            ),
            Row(
              children: [
                Expanded(child: Container(height: 300, width: 200, child: TabCharsGrid())),
              ],
            ),
          ]
        ),
      actions: <Widget>[
        Center(child: TextButton(
          child: Text("Add",
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue)
          ),
          onPressed: (){
            setState(() {

              

              takeScreenshot().then((value) {
                TabProgressionModel tempTab = TabProgressionModel((tabTitle=="")? "Main": tabTitle, tabImage);
                _song.progressions.add(tempTab);
                Navigator.of(context).pop(customController.text.toString());
              });

              
            });
          }),
        )
      ],
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
            child: TextButton(
              onPressed: (){
                setState(() {
                  String tempPatternName = customController.text.toString();

                  if(tempPatternName == "") {tempPatternName="Main";}
                  
                  StrummingPatternModel temp = StrummingPatternModel(tempPatternName,
                  strummingCheckBoxListUp.boxState,
                  strummingCheckBoxListDown.boxState);

                  strummingPatterns.add(temp);

                  Navigator.of(context).pop(customController.text.toString());

                });
              },
              child: Text("Add",
              style: TextStyle(
              fontSize: 20,
              color: Colors.blue),
              ),
            ),
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

                TextButton(
                  child: Text("Chords",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue),
                      ),
                  onPressed: (){
                    setState(() {
                         
                      ChordsProgressionModel chordsTemp = ChordsProgressionModel(
                        customController.text.toString());
                      _song.progressions.add(chordsTemp);
                     
                      Navigator.of(context).pop(customController.text.toString());
                    });
                  }
                ),
              TextButton(
                  child: Text("Tab",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue),
                      ),
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).pop(customController.text.toString());
                      showAddTabDialog(context, customController.text.toString());
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
        
        Widget returnWidget;
        if(progressions[index] is ChordsProgressionModel){
          returnWidget = ChordProgressionWidget(
            chords: (progressions[index] as ChordsProgressionModel).chords);
        }
        else{
          returnWidget = (progressions[index] as TabProgressionModel).tab;
        }

        return Column(children: [
          
          Text(progressions[index].name, textAlign: TextAlign.center,),
          Wrap(children: [
            returnWidget,
           
            
          ]),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: (){
              deleteProgression(context, index);
            }),
          Divider(),
        ],);
    });
  }

  deleteProgression(BuildContext context, int index){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Delete progression?", textAlign: TextAlign.center,),
        actions: <Widget>[
          Center(child: TextButton(
            child: Text("Confirm", style: TextStyle(color: Colors.red, fontSize: 20,)),
            onPressed: (){
              setState(() {
                progressions.removeAt(index);
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
            Text(_song.name, style: TextStyle(fontSize: 20, fontFamily: "Ubuntu", fontWeight: FontWeight.bold)),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Tempo: ${_currentTempoValue.round().toString()}",
                style: TextStyle(fontSize: 20),
                ),
                FloatingActionButton(heroTag: null ,onPressed: () {
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
                        _song.tempo = value;
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
            //SizedBox(height: 30),
            Row( children: [
              FloatingActionButton(heroTag: null,
                onPressed: () {
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
            //SizedBox(height: 30),
            Row(children: [
              FloatingActionButton(heroTag: null, onPressed: () {
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