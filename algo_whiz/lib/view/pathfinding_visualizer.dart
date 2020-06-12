import 'package:algo_whiz/utils/colors.dart';
import 'package:flutter/material.dart';

const double boxNodeWidth = 40;
const double boxNodeHeight = 40;

class PathfindingVisualizer extends StatefulWidget {
  @override
  _PathfindingVisualizerState createState() => _PathfindingVisualizerState();
}

class _PathfindingVisualizerState extends State<PathfindingVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PathFinding"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(child: NodeGrid()),
    );
  }
}

List<Widget> generateBoxNodes(int noXAxisNodes, int noYAxisNodes) {
  List<Widget> boxNodes = [];
  for (int i = 0; i < noXAxisNodes; i++) {
    for (int j = 0; j < noYAxisNodes; j++) {
      boxNodes.add(Node());
    }
  }
  return boxNodes;
}

class Node extends StatelessWidget {
  const Node({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        child: Container(
            height: boxNodeHeight,
            width: boxNodeWidth,
            decoration: BoxDecoration(
              border: Border.all(color: colorLightSteelBlue),
            )));
  }
}

class NodeGrid extends StatefulWidget {
  @override
  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    var noXAxisNodes = screenWidth ~/ boxNodeWidth;
    var noYAxisNodes = screenHeight ~/ boxNodeHeight;

    return Container(
      child: GridView.count(
        crossAxisCount: noXAxisNodes,
        physics: NeverScrollableScrollPhysics(),
        children: generateBoxNodes(noXAxisNodes, noYAxisNodes),
      ),
    );
  }
}
