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
        title: Consumer<PathFindingViewModel>(
            builder: (BuildContext context, PathFindingViewModel value,
                    Widget child) =>
                Row(
                  children: <Widget>[
                    Text("PathFinding"),
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        value.bfs();
                      },
                    ), IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        value.reset();
                      },
                    )
                  ],
                )),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: NodeGrid(),
      ),
    );
  }
}

/// The UI container that holds a node
class NodeContainer extends StatefulWidget {
  const NodeContainer({
    Key key,
    this.nodeIndex,

  }) : super(key: key);

  final int nodeIndex;
  @override
  _NodeContainerState createState() => _NodeContainerState();
}

class _NodeContainerState extends State<NodeContainer> {
  BoxDecoration _getBoxDecoration(Node node) {
    if (node.status == NodeStatus.VISITED) {
      return BoxDecoration(
        color:  swatchColors[700],
        border: Border.all(color:swatchColors[500]),
      );
    } else if (node.status == NodeStatus.PATH) {
      return BoxDecoration(
        color: Colors.yellow,
        border: Border.all(color: colorLightSteelBlue),
      );
    }  else if (node.isTargetNode) {
      return BoxDecoration(
        color: Colors.red,
        border: Border.all(color: colorLightSteelBlue),
      );
    } else if (node.isStartNode) {
      return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colorLightSteelBlue),
      );
    } else {
      return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: swatchColors[100])
      );
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<PathFindingViewModel>(builder:
          (BuildContext context, PathFindingViewModel value, Widget child) {
        Node node = value.nodes[widget.nodeIndex];
        return AnimatedContainer(
            decoration: _getBoxDecoration(node),
            duration: Duration(milliseconds: 500),
            child: Container(
              height: nodeContainerHeight,
              width: nodeContainerWidth,
            ));
      });
}

/// Widget that cotains all NodeContainera aligned in the form of Grid
class NodeGrid extends StatefulWidget {
  const NodeGrid({Key key}) : super(key: key);

  @override
  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int noYAxisNodes = screenWidth ~/ nodeContainerWidth;
    return Container(
      child: GridView.count(
        crossAxisCount: noYAxisNodes,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ...Provider.of<PathFindingViewModel>(context, listen: false)
              .nodes
              .map((node) => 
                      NodeContainer(
                        nodeIndex: node.index,
                      ))
        ],
      ),
    );
  }
}
