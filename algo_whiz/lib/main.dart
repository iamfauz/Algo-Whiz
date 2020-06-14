import 'package:algo_whiz/utils/colors.dart';
import 'package:algo_whiz/ui/home_screen.dart';
import 'package:algo_whiz/viewmodel/pathfinding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => PathFindingViewModel(), child: MainApp()));

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AlgoWhiz',
        theme: ThemeData(
          primarySwatch: primarySwatch,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}

