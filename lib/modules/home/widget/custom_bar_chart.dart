import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/bar_category.dart';
import '../data/bar_group.dart';
import '../data/bar_value.dart';

class CustomBarChart extends StatelessWidget {
  final String title;
  final List<BarGroup> groups;
  final List<BarCategory> categories;

  const CustomBarChart({
    super.key,
    required this.title,
    required this.groups,
    required this.categories,
  });

  double _getTotal(int index) {
    if (index < 0 || index >= groups.length) return 0;
    double total = 0;
    for (final val in groups[index].values) {
      total += val.value;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double maxTotal = 0;
    for (int i = 0; i < groups.length; i++) {
      final t = _getTotal(i);
      if (t > maxTotal) maxTotal = t;
    }
    final yMax = maxTotal > 0 ? (maxTotal * 1.4) : 100000.0;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A3D) : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLegend(textColor),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: yMax,
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.transparent,
                      tooltipPadding: EdgeInsets.zero,
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final currentTotal = rod.toY;
                        final prevTotal = _getTotal(groupIndex - 1);

                        String percentText = '';
                        Color percentColor = Colors.transparent;

                        if (groupIndex > 0 && prevTotal > 0) {
                          final diff = currentTotal - prevTotal;
                          final percent = (diff / prevTotal) * 100;
                          if (percent > 0) {
                            percentText = '▲+${percent.toStringAsFixed(0)}%';
                            percentColor = Colors.greenAccent;
                          } else if (percent < 0) {
                            percentText = '▼${percent.toStringAsFixed(0)}%';
                            percentColor = Colors.redAccent;
                          }
                        }

                        // Formatar o valor total: ex: 467500 -> 467,5k
                        String formattedTotal = 'R\$ ${(currentTotal / 1000).toStringAsFixed(1).replaceAll('.', ',')}k';
                        if (formattedTotal.endsWith(',0k')) {
                          formattedTotal = formattedTotal.replaceFirst(',0k', 'k');
                        }

                        return BarTooltipItem(
                          percentText.isNotEmpty ? '$percentText\n' : '',
                          TextStyle(
                            color: percentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: formattedTotal,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  titlesData: _titles(yMax, textColor),
                  gridData: _grid(textColor),
                  borderData: FlBorderData(show: false),
                  barGroups: _buildGroups(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color textColor) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 12,
      children: categories.map((category) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              color: category.color,
            ),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  List<BarChartGroupData> _buildGroups() {
    return List.generate(groups.length, (i) {
      final group = groups[i];

      double current = 0;
      final stack = <BarChartRodStackItem>[];

      for (final category in categories) {
        final value = group.values
            .firstWhere(
              (e) => e.category == category.name,
          orElse: () => BarValue(category: category.name, value: 0),
        )
            .value;

        if (value > 0) {
          stack.add(
            BarChartRodStackItem(
              current,
              current + value,
              category.color,
            ),
          );
        }

        current += value;
      }

      return BarChartGroupData(
        x: i,
        showingTooltipIndicators: [0], // Força a exibição do tooltip
        barRods: [
          BarChartRodData(
            toY: current,
            rodStackItems: stack,
            width: 24,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
        ],
      );
    });
  }

  FlTitlesData _titles(double yMax, Color textColor) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index >= groups.length || index < 0) return const SizedBox();

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                groups[index].label,
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 60,
          interval: 100000,
          getTitlesWidget: (value, meta) {
            if (value >= yMax * 0.95) {
              return const SizedBox();
            }
            
            String formatted = value.toInt().toString();
            if (value >= 1000) {
              formatted = '${(value / 1000).toInt()}.000';
            }
            if (value == 0) formatted = '0';
            
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                formatted,
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 12,
                ),
                textAlign: TextAlign.right,
              ),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  FlGridData _grid(Color textColor) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 100000,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: textColor.withOpacity(0.08),
          strokeWidth: 1,
          dashArray: [5, 5],
        );
      },
    );
  }
}


/*
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatefulWidget {
  CustomBarChart({super.key});

  final Color dark = Colors.cyan.shade100;
  final Color normal = Colors.cyan.shade50;
  final Color light = Colors.cyan;

  @override
  State<StatefulWidget> createState() => CustomBarChartState();
}

class CustomBarChartState extends State<CustomBarChart> {
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text = switch (value.toInt()) {
      0 => 'Apr',
      1 => 'May',
      2 => 'Jun',
      3 => 'Jul',
      4 => 'Aug',
      _ => '',
    };
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      meta: meta,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barsSpace = 4.0 * constraints.maxWidth / 400;
            final barsWidth = 8.0 * constraints.maxWidth / 250;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: const BarTouchData(
                  enabled: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    // color: AppColors.borderColor.withValues(alpha: 0.1),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barsSpace,
                barGroups: getData(barsWidth, barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, widget.dark),
              BarChartRodStackItem(2000000000, 12000000000, widget.normal),
              BarChartRodStackItem(12000000000, 17000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 24000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 13000000000, widget.dark),
              BarChartRodStackItem(13000000000, 14000000000, widget.normal),
              BarChartRodStackItem(14000000000, 24000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 23000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000.5, widget.dark),
              BarChartRodStackItem(6000000000.5, 18000000000, widget.normal),
              BarChartRodStackItem(18000000000, 23000000000.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 29000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.dark),
              BarChartRodStackItem(9000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 29000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 32000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000.5, widget.dark),
              BarChartRodStackItem(2000000000.5, 17000000000.5, widget.normal),
              BarChartRodStackItem(17000000000.5, 32000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 31000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 11000000000, widget.dark),
              BarChartRodStackItem(11000000000, 18000000000, widget.normal),
              BarChartRodStackItem(18000000000, 31000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 35000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 14000000000, widget.dark),
              BarChartRodStackItem(14000000000, 27000000000, widget.normal),
              BarChartRodStackItem(27000000000, 35000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 31000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 8000000000, widget.dark),
              BarChartRodStackItem(8000000000, 24000000000, widget.normal),
              BarChartRodStackItem(24000000000, 31000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 15000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000.5, widget.dark),
              BarChartRodStackItem(6000000000.5, 12000000000.5, widget.normal),
              BarChartRodStackItem(12000000000.5, 15000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.dark),
              BarChartRodStackItem(9000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 17000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 34000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000, widget.dark),
              BarChartRodStackItem(6000000000, 23000000000, widget.normal),
              BarChartRodStackItem(23000000000, 34000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 32000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.dark),
              BarChartRodStackItem(7000000000, 24000000000, widget.normal),
              BarChartRodStackItem(24000000000, 32000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 14000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 1000000000.5, widget.dark),
              BarChartRodStackItem(1000000000.5, 12000000000, widget.normal),
              BarChartRodStackItem(12000000000, 14000000000.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 20000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 4000000000, widget.dark),
              BarChartRodStackItem(4000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 20000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 24000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 4000000000, widget.dark),
              BarChartRodStackItem(4000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 24000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 14000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 1000000000.5, widget.dark),
              BarChartRodStackItem(1000000000.5, 12000000000, widget.normal),
              BarChartRodStackItem(12000000000, 14000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 27000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.dark),
              BarChartRodStackItem(7000000000, 25000000000, widget.normal),
              BarChartRodStackItem(25000000000, 27000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 29000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000, widget.dark),
              BarChartRodStackItem(6000000000, 23000000000, widget.normal),
              BarChartRodStackItem(23000000000, 29000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 16000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.dark),
              BarChartRodStackItem(9000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 16000000000.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 15000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.dark),
              BarChartRodStackItem(7000000000, 12000000000.5, widget.normal),
              BarChartRodStackItem(12000000000.5, 15000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }
}*/
