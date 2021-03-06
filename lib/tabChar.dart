import 'package:flutter/material.dart';


class TabChar extends StatelessWidget {

  final String charToDraw;

  TabChar({Key? key, required this.charToDraw}): super(key: key);

  final Offset position = Offset(0.0, 200);

  @override
  Widget build(BuildContext context) {
    return Draggable<Text>(
      data: Text(charToDraw, style: TextStyle(backgroundColor: Colors.white,)),
        childWhenDragging: Text(charToDraw, textAlign: TextAlign.center,),
        feedback: Material(child: Text(charToDraw)),
            child: Container(
              alignment: Alignment.center,
              child: Text(charToDraw),
      ),
    );
  }
}