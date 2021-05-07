import 'dart:typed_data';
import 'dart:ui';
import 'package:choorts/chordProgressionWidget.dart';
import 'package:choorts/metromeSound.dart';
import 'package:choorts/models/progressionModel.dart';
import 'package:choorts/models/strummingPatternModel.dart';
import 'package:choorts/playPauseButton.dart';
import 'package:choorts/strummingCheckBoxList.dart';
import 'package:choorts/strummingPatternList.dart';
import 'package:choorts/tabCharsGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
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

  final Box<dynamic> songsBox;
  final songIndex;
  

  SongDetails({Key? key, required this.songsBox, required this.songIndex}): super(key: key);

  @override
  _SongDetailsState createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {

  MetronomeSound _metronomeSound = new MetronomeSound();

  late Box<dynamic> _songsBox;
  Song _song = Song("def", "def");
  double _currentTempoValue = 80;
  bool _isTempoSliderVisible = false;

  List<ProgressionModel> _progressions = [];
  List<StrummingPatternModel> _strummingPatterns = [];

  int _songIndex = 0;

  @override
  void initState(){

    _songsBox = widget.songsBox;
    _songIndex = widget.songIndex;
    _song = widget.songsBox.getAt(_songIndex);

    _currentTempoValue = _song.tempo;
    _progressions = _song.progressions;
    _strummingPatterns = _song.strummingPatterns;

    _metronomeSound.setTempo(_currentTempoValue);

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
    Uint8List imageAsUint8 = Uint8List(10);
    var src = new GlobalKey();

    takeScreenshot() async{
      RenderRepaintBoundary repaintBoundary = src.currentContext!.findRenderObject() as RenderRepaintBoundary;
      repaintBoundary.toImage();
      var image = await repaintBoundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      imageAsUint8 = byteData!.buffer.asUint8List();
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
              y = details.offset.dy - 170.0;
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
      Container(height: 200, width: 300, child: TabCharsGrid()),
      ]),
        actions: <Widget>[
          TextButton(
            child: Text("Add",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor
              )
                    ),
                    onPressed: (){
              setState(() {

                takeScreenshot().then((value) {
                  ProgressionModel tempTab = ProgressionModel((tabTitle=="")? "Main": tabTitle, false);
                  tempTab.tabImage = imageAsUint8;

                  setState(() {
                    _progressions.add(tempTab);
                    _songsBox.putAt(_songIndex, _song);
                  });
                  
                  Navigator.of(context).pop(customController.text.toString());
                });
        
              });
          }),
          TextButton(onPressed: (){
            Navigator.of(context).pop(customController.text.toString());
          },
          child: Text("Cancel", style: 
            TextStyle(color: Colors.red, fontSize: 20,)
            )
          ),
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
          TextButton(
            onPressed: (){
              setState(() {
                String tempPatternName = customController.text.toString();

                if(tempPatternName == "") {tempPatternName="Main";}
                
                StrummingPatternModel temp = StrummingPatternModel(tempPatternName,
                strummingCheckBoxListUp.boxState,
                strummingCheckBoxListDown.boxState);

                _strummingPatterns.add(temp);
                _songsBox.putAt(_songIndex, _song);

                Navigator.of(context).pop(customController.text.toString());

              });
            },
            child: Text("Add",
            style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).accentColor)
            ),
          ),
          TextButton(onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
            child: Text("Cancel", style: 
              TextStyle(color: Colors.red, fontSize: 20,)
              )
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

              TextButton(
                child: Text("Chords",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor),
                    ),
                onPressed: (){
                  setState(() {
                       
                    ProgressionModel chordsTemp = ProgressionModel(
                      customController.text.toString(), true);

                    _song.progressions.add(chordsTemp);

                    _songsBox.putAt(_songIndex, _song);
                   
                    Navigator.of(context).pop(customController.text.toString());
                  });
                }
              ),
            TextButton(
                child: Text("Tab",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor),
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
          
        ],
      );
    });
    
  }

  getProgressionsList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _progressions.length,
      itemBuilder: (BuildContext context, int index) {
        
        Widget returnWidget = Text("here is Progression");

        if(_progressions[index].isChordsProgression){

          returnWidget = ChordProgressionWidget( songsBox: _songsBox,
            songIndex:  _songIndex,
            chords: _progressions[index].chords,
            song: _song,);
          
          
        }
        else{
          returnWidget = Image.memory(_progressions[index].tabImage.buffer.asUint8List());
          //returnWidget = Text("here should be Tab progression");
        }

        return Column(children: [
          
          Text(_progressions[index].name, textAlign: TextAlign.center,
           style: Theme.of(context).textTheme.headline3),
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
                _progressions.removeAt(index);
                _songsBox.putAt(_songIndex, _song);
                Navigator.of(context).pop();
              });
          })
          ),
        ],
      );
    });
  }

  Icon btnPlayIcon = Icon(Icons.play_arrow);
  Color btnPlayColor = Colors.green;
  bool btnPlayState = false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myGlobals._scaffoldKey,
      appBar: AppBar (
        title: Text("Choorts", style: GoogleFonts.pacifico()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Center(
          child: Column(
          children: <Widget>[
            Text(_song.name, style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Tempo: ${_currentTempoValue.round().toString()}",
                style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                  PlayPauseButton(metronomeSound: _metronomeSound),
                  SizedBox(width: 10),
                  FloatingActionButton(heroTag: null ,onPressed: () {
                      showTempoSlider();
                    },
                    child: Icon(Icons.add),
                  ),
                ],)
                
              ],
            ),
            Row(children: [
              Visibility(
                visible: _isTempoSliderVisible,
                child: Expanded(
                  child: Slider(
                    activeColor: Theme.of(context).primaryColor,
                    value: _currentTempoValue,
                    min:1,
                    max:200,
                    label: _currentTempoValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentTempoValue = value;
                        _song.tempo = value;
                        _songsBox.putAt(_songIndex, _song);

                        _metronomeSound.setTempo(_currentTempoValue);
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
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ],),
            SizedBox(height: 30),
            StrummingPatternList(songsBox: _songsBox, songIndex: _songIndex, song: _song,),
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
              style: Theme.of(context).textTheme.headline2)
            ],),
            SizedBox(height: 30),
            getProgressionsList(),
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