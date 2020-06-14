import 'package:algo_whiz/model/node.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double nodeContainerWidth = 40;
const double nodeContainerHeight = 40;

class PathFindingViewModel extends ChangeNotifier {
  /// List of nodes that belong to the graph
  List<Node> _nodes = [];
  bool isAlgoComplete = false;
  int _noXAxisNodes;
  int _noYAxisNodes;


  /// getters
  List<Node> get nodes => _nodes;
  int get noXaxisNodes => _noXAxisNodes;
  int get noYaxisNodes => _noYAxisNodes;
  
  // setters
  set nodes(List<Node> newNodesList) {
    assert(newNodesList != null);
    _nodes = newNodesList;
    notifyListeners();
  }

  void initGraphNodes({BuildContext context}) {
  /// Screen Width and height are required to calculate
  /// the total number of nodes required for the graph
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    _noYAxisNodes = screenWidth ~/ nodeContainerWidth;
    _noXAxisNodes = screenHeight ~/ nodeContainerHeight;

    List<Node> nodes = [];
    for (int x = 0; x < _noXAxisNodes; x++) {
      for (int y = 0; y < _noYAxisNodes; y++) {
        nodes.add(Node(x: x, y: y));
      }
    }
    _nodes = nodes;
  }
}
