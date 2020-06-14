import 'dart:math';

import 'package:algo_whiz/paint/bar_painter.dart';
import 'package:algo_whiz/ui/sorting_scaffold.dart';
import 'package:algo_whiz/utils/colors.dart';
import 'package:algo_whiz/ui/pathfinding_scaffold.dart';
import 'package:algo_whiz/viewmodel/pathfinding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AlgoWhiz"),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          BackgroundPattern(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(3.0),
                children: <Widget>[
                  DashBoardItem(
                    title: "Sorting",
                    icon: Icons.equalizer,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SortingScaffold()),
                      );
                    },
                  ),
                  DashBoardItem(
                    title: "Pathfinding",
                    icon: Icons.search,
                    onPressed: () {
                      List nodes = Provider.of<PathFindingViewModel>(context,
                              listen: false)
                          .nodes;

                      if (nodes == null || nodes.isEmpty) {
                        Provider.of<PathFindingViewModel>(context, listen: false)
                            .initGraphNodes(context: context);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PathfindingScaffold()),
                      );
                    },
                  ),
                  DashBoardItem(
                      title: "Runtimes",
                      icon: Icons.access_time,
                      onPressed: () {}),
                  DashBoardItem(
                    title: "Code",
                    icon: Icons.code,
                    onPressed: () {},
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class DashBoardItem extends StatelessWidget {
  DashBoardItem({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: new EdgeInsets.all(6.0),
        child: Container(
          child: new InkWell(
            onTap: () => onPressed(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.blueGrey,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 19)),
                )
              ],
            ),
          ),
        ));
  }
}

class BackgroundPattern extends StatefulWidget {
  @override
  _BackgroundPatternState createState() => _BackgroundPatternState();
}

class _BackgroundPatternState extends State<BackgroundPattern> {
  List<int> _numbers = [];

  double _sampleSize = 320;

  @override
  Widget build(BuildContext context) {
    _numbers = [];
    // Generating randomized list
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    _numbers.sort();
    int counter = 0;

    return Row(
      children: _numbers.map((int num) {
        counter++;
        return Container(
          child: CustomPaint(
            painter: HomeScreenBarPainter(
                index: counter,
                value: num,
                width: MediaQuery.of(context).size.width / _sampleSize),
          ),
        );
      }).toList(),
    );
  }
}
