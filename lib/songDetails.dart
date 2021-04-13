import 'dart:ui';

import 'package:flutter/material.dart';
import 'main.dart';

class SongDetails extends StatefulWidget {
  @override
  _SongDetailsState createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {

  double _currentTempoValue = 20;
  bool _isTempoSliderVisible = true;


  void showTempoSlider() {
    setState(() {
      _isTempoSliderVisible = !_isTempoSliderVisible;
    });
  }

  addProgression(BuildContext context){

    TextEditingController customController  =  new TextEditingController();
    

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Choose progression",
        textAlign: TextAlign.center),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Choorts"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SongList()
                )
              );
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
          Row(children: [
            FloatingActionButton(onPressed: () {
              addProgression(context);
            },
            child: Icon(Icons.add)),
          ],)
        ] ,
      ),
    ),
    )   
    );
    
    
    
    
  }
}