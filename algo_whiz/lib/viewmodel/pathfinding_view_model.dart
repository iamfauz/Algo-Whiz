import 'dart:collection';

import 'package:algo_whiz/model/node.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double nodeContainerWidth = 40;
const double nodeContainerHeight = 40;
const int maxAnimationSpeedInMilliSec = 300;

/// Viewmodel that contains all buisness logic for the Pathfindign Scaffold
class PathFindingViewModel extends ChangeNotifier {
  /// List of nodes that belong to the graph
  List<Node> _nodes = [];
  List<List<Node>> _graph = [];
  bool isAlgoComplete = true;
  int _noXAxisNodes;
  int _noYAxisNodes;
  Node _startNode;
  Node _targetNode;
  bool _isInstantMode = false; // instant mode does no animation 
  bool _isClearGrid = true;
  int _animationSpeedInMilliSec = ( maxAnimationSpeedInMilliSec* 0.5).toInt();
  double _animationSpeedFactor = 0.85; // percent of the baseAnimationSpeed applied

  /// getters
  List<Node> get nodes => _nodes;
  List<List<Node>> get graph => _graph;
  int get noXaxisNodes => _noXAxisNodes;
  int get noYaxisNodes => _noYAxisNodes;
  Node get startNode => _startNode;
  Node get targetNode => _targetNode;
  bool get isInstantMode => _isInstantMode;
  bool get isClearGrid => _isClearGrid;
  int get animationInSeconds => _animationSpeedInMilliSec;
  double get animationSpeedFactor => _animationSpeedFactor;

  // setters
  set nodes(List<Node> newNodesList) {
    assert(newNodesList != null);
    _nodes = newNodesList;
    notifyListeners();
  }

  set isInstantMode(bool isInstantMode){
    _isInstantMode = isInstantMode;
    notifyListeners();
  }

  set isClearGrid(bool isClearGrid){
    _isClearGrid = isClearGrid;
    notifyListeners();
  }

  set animationSpeedFactor(double speedFactor){
    _animationSpeedFactor = speedFactor;
    notifyListeners();
  }

  
   // Set animation in speed from speed Factor
  void setAnimationSpeedinSeconds(double speedFactor){
    _animationSpeedInMilliSec = ( maxAnimationSpeedInMilliSec * (1 - speedFactor)).toInt();
    notifyListeners();
  }

  /// Instantiates all Nodes and
  /// maps them to the correct gris co-ordinates
  void initGraphNodes({BuildContext context}) {
    /// Screen Width and height are required to calculate
    /// the total number of nodes required for the graph
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    _noYAxisNodes = screenWidth ~/ nodeContainerWidth;
    _noXAxisNodes = screenHeight ~/ nodeContainerHeight;

    List<Node> nodes = [];
    int index = -1;
    for (int x = 0; x < _noXAxisNodes; x++) {
      for (int y = 0; y < _noYAxisNodes; y++) {
        index++;
        Node node;
        if ((x == 1) && (y == 2)) {
          node = Node(x: x, y: y, isStartNode: true, index: index);
          _startNode = node;
        } else if ((x == 5) && (y == 5)) {
          node = Node(x: x, y: y, isTargetNode: true, index: index);
          _targetNode = node;
        } else {
          node = Node(x: x, y: y, index: index);
        }

        nodes.add(node);
      }
    }
    _nodes = nodes;
  }

  /// Breadth First Search Algorithm
  bfs() async {

    reset();

    isAlgoComplete = false;
    notifyListeners();

    Queue<Node> queue = Queue();
    Map exploredNodes = {_startNode.index: true};
    queue.add(_startNode);
    while (queue.isNotEmpty) {
      Node currentNode = queue.removeFirst();
      _setNodeStatus(currentNode, NodeStatus.VISITED);
      if (currentNode == targetNode) {
        break;
      }
      List neighbours = getNeighbours(currentNode);
      neighbours.forEach((node) {
        if (exploredNodes[node.index] == null || !exploredNodes[node.index]) {
          _nodes[node.index].previousNode = currentNode;
          queue.add(node);
          exploredNodes[node.index] = true;
        }
      });
      await Future.delayed(getAnimationDuration());
      if(!isInstantMode) notifyListeners();
    }
    await _animateShortestPath();

    isAlgoComplete = true;
    _isClearGrid = false;
    notifyListeners();
  }

  /// Find shortest path by tracing previous node and
  /// animate the shortest path
  _animateShortestPath() async {
    List shortestPath = [];

    //Finf shortest Path
    Node node = _targetNode;
    while (node != null) {
      shortestPath.add(node);
      node = node.previousNode;
    }

    shortestPath = List.from(shortestPath.reversed);

    if (shortestPath.length > 1) {
      //If shortest Path exists

      for (Node node in shortestPath) {
        _setNodeStatus(node, NodeStatus.PATH);
        await Future.delayed(getAnimationDuration());
        notifyListeners();
      }
    }
  }

  /// Gets Neighbours in the grid
  /// A node A is considered to be a neighbor of B,
  /// if A is perpendicular to B
  List<Node> getNeighbours(Node rootNode) => _nodes
      .where((node) =>
          (((rootNode.x == node.x && (rootNode.y - node.y).abs() == 1) ||
              (rootNode.y == node.y && (rootNode.x - node.x).abs() == 1))))
      .toList();

  void setDraggableNode(Node startNode, Node endNode) {
    if (startNode.isStartNode) {
      _nodes[startNode.index].isStartNode = false;
      _nodes[endNode.index].isStartNode = true;
      _startNode = endNode;
    } else if(startNode.isTargetNode){
      _nodes[startNode.index].isTargetNode = false;
      _nodes[endNode.index].isTargetNode = true;
      _targetNode = endNode;
    }
    notifyListeners();
  }

  /// Resets the statuses of all nodes
  void reset() {
    _nodes.forEach((node) {
      node.status = NodeStatus.UNVISITED;
      node.previousNode = null;
    });
    notifyListeners();
  }

  void _clearShortestPath(){
    _nodes.forEach((node) {
      node.previousNode = null;
    });
  }

  void _setNodeStatus(Node node, NodeStatus status) {
    _nodes[node.index].status = status;
  }

  Duration getAnimationDuration({int offset = 0}){
    return Duration(milliseconds: isInstantMode? 0 : _animationSpeedInMilliSec + offset);
  }
}
