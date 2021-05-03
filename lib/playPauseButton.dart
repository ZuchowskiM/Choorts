import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {

  Icon btnIcon = Icon(Icons.play_arrow);
  Color btnColor = Colors.green;
  bool btnState = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        child: btnIcon,
          backgroundColor: btnColor,
          heroTag: null ,
          onPressed: (){
            setState(() {
              
              if(!btnState){
                btnIcon = Icon(Icons.pause);
                btnColor = Colors.red;
                btnState = !btnState;

              }
              else{
                btnIcon = Icon(Icons.play_arrow);
                btnColor = Colors.green;
                btnState = !btnState;
              }

            });
        }),
    );
  }



  
}