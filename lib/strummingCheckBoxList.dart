import 'package:flutter/material.dart';


class strummingCheckBoxList extends StatefulWidget {

  final bool isStrummingUp;

  const strummingCheckBoxList({Key? key, required this.isStrummingUp}): super(key: key);

  @override
  _strummingCheckBoxListState createState() => _strummingCheckBoxListState();
}

class _strummingCheckBoxListState extends State<strummingCheckBoxList> {

  List<bool> _checkBoxState = [false, false, false ,false, false, false, false, false];
  
  getStrummingIcon(bool isStrummingUp){
    if(isStrummingUp){
      return Icon(Icons.arrow_upward);
    }
    else{
      return Icon(Icons.arrow_downward);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
       children: [
          getStrummingIcon(widget.isStrummingUp),
          Expanded(child: Checkbox(value: _checkBoxState[0], onChanged: (newValue){setState(() {
            _checkBoxState[0] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[1], onChanged: (newValue){setState(() {
            _checkBoxState[1] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[2], onChanged: (newValue){setState(() {
            _checkBoxState[2] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[3], onChanged: (newValue){setState(() {
            _checkBoxState[3] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[4], onChanged: (newValue){setState(() {
            _checkBoxState[4] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[5], onChanged: (newValue){setState(() {
            _checkBoxState[5] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[6], onChanged: (newValue){setState(() {
            _checkBoxState[6] = newValue!;
          });},)),
          Expanded(child: Checkbox(value: _checkBoxState[7], onChanged: (newValue){setState(() {
            _checkBoxState[7] = newValue!;
          });},)),
       ],
    );
  }
}