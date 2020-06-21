import 'package:flutter/material.dart';

class Node {
  final int x;
  final int y;
  final int index;
  bool isVisited;
  bool belongsToPath;
  bool isStartNode;
  bool isTargetNode;

  Node(
      {@required this.x,
      @required this.y,
      @required this.index,
      this.isStartNode = false,
      this.isTargetNode = false,
      this.isVisited = false,
      this.belongsToPath = false});

  @override
  bool operator ==(Object other) =>
      other is Node && other.x == x && other.y == y;

  @override
  int get hashCode => "$x:$y".hashCode;
  
}
