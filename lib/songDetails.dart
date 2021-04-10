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
      body: Center(
      child: Column(
        children: <Widget>[
          Text("song details here"),
          FloatingActionButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SongList()
              )
            );
          })
        ] ,
      ),
    ),
    );
    
    
    
    
  }
}