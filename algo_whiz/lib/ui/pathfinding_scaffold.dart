import 'package:algo_whiz/utils/colors.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(child: NodeGrid()),
    );
  }
}

List<Widget> generateNodeContainers(int noXAxisNodes, int noYAxisNodes) {
  List<Widget> nodeContainers = [];
  for (int x = 0; x < noXAxisNodes; x++) {
    for (int y = 0; y < noYAxisNodes; y++) {
      Node node = Node(x: x, y:y);
      nodeContainers.add(NodeContainer(node: node,));
    }
  }
  return nodeContainers;
}

/// The UI container that holds a node
class NodeContainer extends StatelessWidget {
  const NodeContainer({
    Key key, this.node,
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
  @override
  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    var noYAxisNodes = screenWidth ~/ nodeContainerWidth;
    var noXAxisNodes = screenHeight ~/ nodeContainerHeight;

    return Container(
      child: GridView.count(
        crossAxisCount: noYAxisNodes,
        physics: NeverScrollableScrollPhysics(),
        children: generateNodeContainers(noXAxisNodes, noYAxisNodes),
      ),
    );
  }
}

class Node {
  final int x;
  final int y;
  bool isVisitedNode;
  bool belongsToPath;
  bool isStartNode;
  bool isEndNode;
  
  Node(
      {@required this.x,
      @required this.y,
      isVisited = false,
      belongsToPath = false});
}
