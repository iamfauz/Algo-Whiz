import 'package:algo_whiz/model/node.dart';
import 'package:algo_whiz/utils/colors.dart';
import 'package:algo_whiz/viewmodel/pathfinding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double nodeContainerWidth = 40;
const double nodeContainerHeight = 40;

class PathfindingScaffold extends StatefulWidget {
  @override
  _PathfindingScaffoldState createState() => _PathfindingScaffoldState();
}

class _PathfindingScaffoldState extends State<PathfindingScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PathFinding"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: Consumer<PathFindingViewModel>(
        builder:
            (BuildContext context, PathFindingViewModel value, Widget child) =>
                NodeGrid(model: value),
      )),
    );
  }
}

/// The UI container that holds a node
class NodeContainer extends StatelessWidget {
  const NodeContainer({
    Key key,
    this.node,
  }) : super(key: key);

  final Node node;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        child: Container(
            child: Text("${node.x.toString()},${node.y.toString()}"),
            height: nodeContainerHeight,
            width: nodeContainerWidth,
            decoration: BoxDecoration(
              border: Border.all(color: colorLightSteelBlue),
            )));
  }
}

/// Widget that cotains all NodeContainera aligned in the form of Grid
class NodeGrid extends StatefulWidget {
  final PathFindingViewModel model;

  const NodeGrid({Key key, this.model}) : super(key: key);

  @override
  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: widget.model.noYaxisNodes,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ...widget.model.nodes.map((node) => NodeContainer(node: node))
        ],
      ),
    );
  }
}
