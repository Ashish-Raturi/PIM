import 'package:flutter/material.dart';

const c1 = Color(0xFF3DA4F9);
const c2 = Color(0xFF116BFF);
const c3 = Color(0xFF9897A4);
const c4 = const Color(0xffe6e5e5);
const c5 = const Color(0xff004d40);
const gold = Color(0xffffd45b);

const textInputDecoration = InputDecoration(
    alignLabelWithHint: true,
    labelStyle: TextStyle(
        // color: c2,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
        wordSpacing: 0.5),
    hintStyle: TextStyle(color: c2, letterSpacing: 1),
    focusColor: c1,
    border: OutlineInputBorder(borderSide: BorderSide(color: c1)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: c1)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: c2),
    ));
const textInputDecoration2 = InputDecoration(
    hintStyle: TextStyle(color: c2, letterSpacing: 1),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: c2)));

const textInputDecoration3 = InputDecoration(
    hintStyle: TextStyle(color: Colors.deepPurple, letterSpacing: 1),
    alignLabelWithHint: true,
    labelStyle: TextStyle(
        color: Colors.deepPurple,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
        wordSpacing: 0.5),
    focusColor: c1,
    border:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple),
    ));
