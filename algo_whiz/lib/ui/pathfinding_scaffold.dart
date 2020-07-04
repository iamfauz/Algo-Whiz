import 'package:algo_whiz/model/node.dart';
import 'package:algo_whiz/utils/colors.dart';
import 'package:algo_whiz/viewmodel/pathfinding_view_model.dart';
import 'package:algo_whiz/ui/pathfinding_settings_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double nodeContainerWidth = 40;
const double nodeContainerHeight = 40;

class PathfindingScaffold extends StatelessWidget {
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
                        value.isInstantMode = false;
                        value.bfs();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh,
                          color:
                              value.isAlgoComplete ? Colors.white : Colors.red),
                      onPressed: () {
                        if (value.isAlgoComplete) {
                          value.isClearGrid = true;
                          value.reset();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: false,
                            isDismissible: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) =>
                                PathFindingSettingsBottomSheetWidget(
                                    model: value));
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
  NodeContainer({
    Key key,
    this.nodeIndex,
  }) : super(key: key);
  final int nodeIndex;

  @override
  _NodeContainerState createState() => _NodeContainerState();
}

class _NodeContainerState extends State<NodeContainer> {
  Node previousCandidateNode;

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

  Widget _getNodeContainerChild(Node node, bool isAlgoComplete) {
    if (!node.isStartNode && !node.isTargetNode) {
      return Container();
    } else {
      return Draggable(
        child: _getNodeWidget(node, false),
        feedback: _getNodeWidget(node, true),
        childWhenDragging: Container(),
        data: node,
        maxSimultaneousDrags: isAlgoComplete ? 1 : 0,
      );
    }
  }

  Widget _getNodeWidget(Node node, bool isHover) {
    return Center(
      child: Icon(
        node.isStartNode ? Icons.local_airport : Icons.home,
        color: colorMiddleGrey,
        size: isHover ? 40 : 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Consumer<PathFindingViewModel>(builder:
          (BuildContext context, PathFindingViewModel value, Widget child) {
        Node node = value.nodes[widget.nodeIndex];
        return AnimatedContainer(
            decoration: _getBoxDecoration(node),
            duration: Duration(milliseconds: value.isInstantMode ? 0 : 500),
            child: DragTarget(
                builder: (context, List<Node> candidateData, rejectedData) {
                  // Call back that's called after the NodeContainerChild is built.
                  // This function runs the runs the algo in instant mode to display the
                  // shortest path dynamically when user is hovering over the grid
                  onChildBuildCallBack() {
                    // if (candidateData.isNotEmpty) {
                    //   // Checks if icon is hovering
                    //   Node candidateNode = candidateData[0];
                    //   if (previousCandidateNode != candidateNode &&
                    //       candidateNode != node &&
                    //       !value.isClearGrid) {
                    //     previousCandidateNode = candidateNode;
                    //     value.isInstantMode = true;
                    //     value.setDraggableNode(candidateNode, node);
                    //     value.bfs();
                    //   }
                    // }
                  }

                  return NodeContainerChild(
                      child: _getNodeContainerChild(node, value.isAlgoComplete),
                      onPostFrameCallBack: onChildBuildCallBack);
                },
                onWillAccept: (startNode) => true,
                onAccept: (startNode) {
                  value.setDraggableNode(startNode, node);
                  if (!value.isClearGrid) {
                    // Running algorithm again as workaround as hover does'nt get recognozed by the system sometimes
                    value.isInstantMode = true;
                    value.bfs();
                  }
                }));
      });
}

class NodeContainerChild extends StatelessWidget {
  final Widget child;
  final Function onPostFrameCallBack;

  const NodeContainerChild({Key key, this.onPostFrameCallBack, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onPostFrameCallBack());
    return Container(
      child: child,
      height: nodeContainerHeight,
      width: nodeContainerWidth,
    );
  }
}

/// Widget that cotains all NodeContainera aligned in the form of Grid
class NodeGrid extends StatelessWidget {
  @override
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
