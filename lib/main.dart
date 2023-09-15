import 'package:flutter/material.dart';
import 'package:loginsignup/splashscreen.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(bodyText1: TextStyle(), bodyText2: TextStyle())
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: splash()));
}
