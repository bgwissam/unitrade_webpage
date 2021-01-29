import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const textStyleParagraph = TextStyle(
    fontFamily: 'San Francisco',
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    wordSpacing: 10.0);

const textStyleParagraph2 = TextStyle(
    fontFamily: 'San Francisco', fontSize: 16.0, fontWeight: FontWeight.bold);

const textStyleParagraph3 = TextStyle(
    fontFamily: 'San Francisco',
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.orange);

const textStyleParagraph4 = TextStyle(
    fontFamily: 'San Francisco',
    fontSize: 36.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: Colors.white);

const textStyleParagraph5 = TextStyle(
    fontFamily: 'San Francisco',
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.red);

const textStyleParagraph6 =
    TextStyle(fontFamily: 'San Francisco', fontSize: 11.0);

const textStyleParagraph7 = TextStyle(fontFamily: 'San Francisco', fontSize: 18.0, color: Colors.white, backgroundColor: Colors.black);

const textStyleParagraph8 = TextStyle(fontSize: 24.0, color: Colors.white);
const textStyleParagraph9 = TextStyle(fontFamily: 'IBMPlexSerif', fontStyle: FontStyle.normal, fontSize: 17.0, color: Colors.black);


const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ));


//Animation text styles 
const isHovingTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 18.0,
);

const isNotHoveringTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
);