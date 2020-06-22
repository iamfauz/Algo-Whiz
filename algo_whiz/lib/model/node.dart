import 'package:flutter/material.dart';

enum NodeStatus { VISITED, PATH, UNVISITED }

class Node {
  final int x;
  final int y;
  final int index;
  Node previousNode;
  NodeStatus status;
  bool isStartNode;
  bool isTargetNode;

  Node({
    @required this.x,
    @required this.y,
    @required this.index,
    this.status = NodeStatus.UNVISITED,
    this.isStartNode = false,
    this.isTargetNode = false,
    this.previousNode,
  });

  @override
  bool operator ==(Object other) =>
      other is Node && other.x == x && other.y == y;

  @override
  int get hashCode => "$x:$y".hashCode;
}
