import 'package:flutter/material.dart';

int getGridCrossAxisCount(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;

  if (width < 600) {
    return 2;
  }
  if (width <= 900) {
    return 3;
  }
  return 4;
}
