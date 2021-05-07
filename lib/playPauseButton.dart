import 'package:choorts/metromeSound.dart';
import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {

  final MetronomeSound metronomeSound;

  PlayPauseButton({Key? key, required this.metronomeSound}): super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();

}

class _PlayPauseButtonState extends State<PlayPauseButton> {

  Icon _btnIcon = Icon(Icons.play_arrow);
  Color _btnColor = Colors.green;
  bool _btnState = false;
  late MetronomeSound _metronomeSound;

  @override
  void initState(){

    _metronomeSound = widget.metronomeSound;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        child: _btnIcon,
          backgroundColor: _btnColor,
          heroTag: null ,
          onPressed: (){
            setState(() {
              
              if(!_btnState){
                _btnIcon = Icon(Icons.pause);
                _btnColor = Colors.red;
                _btnState = !_btnState;

                _metronomeSound.play();

              }
              else{
                _btnIcon = Icon(Icons.play_arrow);
                _btnColor = Colors.green;
                _btnState = !_btnState;

                _metronomeSound.stop();
              }

            });
        }),
    );
  }



  
}