import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'styles.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primaryColor: TurfColors.red,
        backgroundColor: TurfColors.bgColor,
      ),
    );
  }
}