import 'dart:ui';

import 'package:choorts/tabChar.dart';
import "package:flutter/material.dart";


class TabCharsGrid extends StatefulWidget {

  @override
  _TabCharsGridState createState() => _TabCharsGridState();
}

class _TabCharsGridState extends State<TabCharsGrid> {

  List<TabChar> tabChars = [];

  final List<String> chars = [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
  "10", "11", "12", "13", "14", "15", "16", "17", "18",
  "19", "20", "21", "22", "23", "24",
  "/", "h", "p", "b", "\\" ,"~", "x", "t"];

  @override
  void initState() {
    super.initState();
    setupTabCharsList();
  }

  setupTabCharsList(){
    for(int i=0; i<chars.length; i++){
      tabChars.add(TabChar(charToDraw: chars[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: tabChars.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index){
        return tabChars[index];
      });
  }
}