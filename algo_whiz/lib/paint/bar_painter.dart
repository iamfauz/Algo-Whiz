import 'package:algo_whiz/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  Color getPaintColor(int value);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = getPaintColor(this.value);

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 0),
        Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SortingBarPainter extends BarPainter {
  SortingBarPainter({width, value, index})
      : super(width: width, value: value, index: index);
  @override
  Color getPaintColor(int value) {
    if (this.value < 500 * .20) {
      return swatchColors[50];
    } else if (this.value < 500 * .30) {
      return swatchColors[100];
    } else if (this.value < 500 * .40) {
      return swatchColors[200];
    } else if (this.value < 500 * .50) {
      return swatchColors[300];
    } else if (this.value < 500 * .60) {
      return swatchColors[400];
    } else if (this.value < 500 * .70) {
      return swatchColors[500];
    } else if (this.value < 500 * .80) {
      return swatchColors[600];
    } else if (this.value < 500 * .90) {
      return swatchColors[700];
    } else {
      return swatchColors[800];
    }
  }
}

class HomeScreenBarPainter extends BarPainter {
  HomeScreenBarPainter({width, value, index})
      : super(width: width, value: value, index: index);
  @override
  Color getPaintColor(int value) {
    if (this.value < 500 * .30) {
      return swatchColors[50];
    } else if (this.value < 500 * .40) {
      return swatchColors[100];
    } else if (this.value < 500 * .50) {
      return swatchColors[200];
    } else if (this.value < 500 * .60) {
      return swatchColors[300];
    } else if (this.value < 500 * .70) {
      return swatchColors[400];
    } else if (this.value < 500 * .80) {
      return swatchColors[500];
    } 
     else if (this.value < 500 * .90) {
      return swatchColors[600];
    } 
    else  {
      return swatchColors[700];
    } 
  }
}
