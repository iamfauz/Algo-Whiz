import 'package:flutter/material.dart';

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
