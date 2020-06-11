import 'package:flutter/material.dart';

Color primaryColor = Color(0xFF3b3b98);
Color colorDarkBlueGray = Color(0xFF5D5D81);
Color colorLightSteelBlue = Color(0xFFBFCDE0);
Color colorGreyWhite = Color(0xFFFEFCFD);
 
const Map<int, Color> swatchColors = {
  50: Color(0xFFe6deff),
  100: Color(0xFFd1c8f2),
  200: Color(0xFFbdb2e5),
  300: Color(0xFFa99dd8),
  400: Color(0xFF9488cb),
  500: Color(0xFF7f74be),
  600: Color(0xFF6a60b1),
  700: Color(0xFF544da5),
  800: Color(0xFF3b3b98),
};
const int primaryColorHex = 0xFF3b3b98;
Color primarySwatch = MaterialColor(primaryColorHex, swatchColors);