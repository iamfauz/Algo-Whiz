import 'package:algo_whiz/utils/colors.dart';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .20) {
      paint.color = swatchColors[50];
    } else if (this.value < 500 * .30) {
      paint.color = swatchColors[100];
    } else if (this.value < 500 * .40) {
      paint.color = swatchColors[200];
    } else if (this.value < 500 * .50) {
      paint.color = swatchColors[300];
    } else if (this.value < 500 * .60) {
      paint.color = swatchColors[400];
    } else if (this.value < 500 * .70) {
      paint.color = swatchColors[500];
    } else if (this.value < 500 * .80) {
      paint.color = swatchColors[600];
    } else if (this.value < 500 * .90) {
      paint.color = swatchColors[700];
    } else {
      paint.color = swatchColors[800];
    }

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
