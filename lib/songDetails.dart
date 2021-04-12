import 'dart:ui';

import 'package:flutter/material.dart';
import 'main.dart';

class SongDetails extends StatefulWidget {
  @override
  _SongDetailsState createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
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
              Text("Tempo:",
              style: TextStyle(fontSize: 20),
              ),
              FloatingActionButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SongList()
                )
              );
            },
            child: Icon(Icons.add),
            ),
            ],
          ),
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
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SongList()
                )
              );
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