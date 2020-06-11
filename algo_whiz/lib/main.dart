

import 'package:algo_whiz/utils/colors.dart';
import 'package:algo_whiz/view/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: HomeScreen(),
    );
  }
}
