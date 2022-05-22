import 'package:flutter/material.dart';import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


const Color bluishClr = Color(0xFF4e5ae8);
const Color pinkClr = Color(0xFFff4667);
const Color yellowClr = Color(0xFFFFB746);
const Color deepPurpleClr = Color(0xFF7E57C2);
const Color greenClr = Color(0xFF66BB6A);
const Color whiteClr = Colors.white;
const  primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);

class Themes{
  static final light =  ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light,

  );
  static final dark =  ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

