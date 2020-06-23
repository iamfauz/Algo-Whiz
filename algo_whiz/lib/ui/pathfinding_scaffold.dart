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
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh,
                          color:
                              value.isAlgoComplete ? Colors.white : Colors.red),
                      onPressed: () {
                        if (value.isAlgoComplete) {
                          value.reset();
                        }
                      },
                    )
                  ],
                )),
        backgroundColor: colorPurpleNavy,
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
        color: colorPurpleNavy,
        border: Border.all(color: colorDarkJungleGreen),
      );
    } else if (node.status == NodeStatus.PATH) {
      return BoxDecoration(
          color: colorElectricLime, border: Border.all(color: colorOliveGreen));
    } else {
      return BoxDecoration(
          color: Colors.white,
          border: Border.all(color: colorPurpleNavy, width: 0));
    }
  }

  Widget _getNodeContainerChild(Node node) {
    if (!node.isStartNode && !node.isTargetNode) {
      return Container();
    } else {
      return Draggable(
        child: _getNodeWidget(node, false),
        feedback: _getNodeWidget(node, true),
        childWhenDragging: Container(),
        data: node,
      );
    }
  }

  Widget _getNodeWidget(Node node, bool isHover) {
    return Center(
      child: Icon(
        node.isStartNode ? Icons.local_airport : Icons.home,
        color: colorMiddleGrey,
        size: isHover? 40 : 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Consumer<PathFindingViewModel>(builder:
          (BuildContext context, PathFindingViewModel value, Widget child) {
        Node node = value.nodes[widget.nodeIndex];
        return AnimatedContainer(
            decoration: _getBoxDecoration(node),
            duration: Duration(milliseconds: 500),
            child: DragTarget(
                builder: (context, List<Node> candidateData, rejectedData) =>
                    Container(
                      child: _getNodeContainerChild(node),
                      height: nodeContainerHeight,
                      width: nodeContainerWidth,
                    ),
                onWillAccept: (startNode) => true,
                onAccept: (startNode) {
                  value.setDraggableNode(startNode, node);
                }));
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
              .map((node) => NodeContainer(
                    nodeIndex: node.index,
                  ))
        ],
      ),
    );
  }
}
