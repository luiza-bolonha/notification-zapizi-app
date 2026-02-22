import 'dart:ui';

import '../../../global/utils.dart';

class PieChartItem {
  final String label;
  final double value;
  final Color color;

  PieChartItem({
    required this.label,
    required this.value,
  }): color = randomColor();
}