
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

Color randomColor() {
  final random = Random();
  return HSLColor.fromAHSL(
    1,
    random.nextDouble() * 360,
    0.65,
    0.55,
  ).toColor();
}