import 'package:flutter/material.dart';
import 'package:semi_mosqueda/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.green,
      canvasColor: Colors.green[50],
    ),
    home: HomePage(),
  ));
}

