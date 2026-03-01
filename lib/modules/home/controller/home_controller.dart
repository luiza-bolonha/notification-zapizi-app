import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/dto/login_dto.dart';
import '../data/bar_category.dart';
import '../data/bar_group.dart';
import '../data/bar_value.dart';
import '../data/pie_chart_item.dart';

class HomeController extends GetxController {
  final StorageService _storageService = Get.put(StorageService());
  
  final RxBool isDark = false.obs;

  // Chart Data
  final RxList<PieChartItem> pieData = <PieChartItem>[].obs;
  final RxList<BarCategory> barCategories = <BarCategory>[].obs;
  final RxList<BarGroup> barGroups = <BarGroup>[].obs;

  // Predefined palette for categories
  final Map<String, Color> _categoryColors = {
    "Dinheiro": Colors.green,
    "Pix": Colors.amber,
    "Venda Manual": Colors.cyan,
    "Crédito": Colors.red,
    "Débito": Colors.grey,
    "Cartão": Colors.blue,
  };

  // Predefined palette for pie chart (fallback generic colors)
  final List<Color> _pieColors = [
    Colors.deepPurpleAccent,
    Colors.indigoAccent,
    Colors.teal,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.brown,
  ];

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
    _fetchDashboardData();
  }

  Future<void> _loadThemePreference() async {
    isDark.value = await _storageService.isDarkTheme();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    _storageService.saveTheme(isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  Color _getColorForCategory(String name) {
    if (_categoryColors.containsKey(name)) {
      return _categoryColors[name]!;
    }
    // Return a random generated/fallback color if not mapped
    return Colors.primaries[name.hashCode % Colors.primaries.length];
  }

  // Simulating an API call
  Future<void> _fetchDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Fake network delay

    // Assuming we receive this raw data from backend without colors:
    final rawPieData = [
      {"label": "Shopping Vitória", "value": 500.0},
      {"label": "Shopping Vila Velha", "value": 40.0}, // Keep updated user value (was 40)
      {"label": "Loja Marechal", "value": 300.0},
      {"label": "Moxuara Loja", "value": 200.0},
      {"label": "Shopping Mestre Álvaro", "value": 500.0},
    ];

    try {
      final List<PieChartItem> parsedPieData = [];
      for (int i = 0; i < rawPieData.length; i++) {
        final item = rawPieData[i];
        final color = _pieColors[i % _pieColors.length]; // cycle colors
        parsedPieData.add(PieChartItem(
          label: item["label"] as String, 
          value: item["value"] as double, 
          color: color,
        ));
      }
      pieData.assignAll(parsedPieData);

      // Raw Bar Data (categories can be inferred from the data or sent separately)
      final rawCategories = ["Dinheiro", "Pix", "Venda Manual", "Crédito", "Débito", "Cartão"];
      
      final List<BarCategory> parsedCategories = rawCategories.map((name) {
        return BarCategory(name: name, color: _getColorForCategory(name));
      }).toList();

      barCategories.assignAll(parsedCategories);

      // Same data structure from previous mocked code:
      final List<BarGroup> rawBarGroups = [
        BarGroup(label: "Jul", values: [
          BarValue(category: "Cartão", value: 10000),
          BarValue(category: "Pix", value: 300000),
        ]),
        BarGroup(label: "Ago", values: [
          BarValue(category: "Dinheiro", value: 70000),
          BarValue(category: "Débito", value: 300000),
        ]),
        BarGroup(label: "Set", values: [
          BarValue(category: "Dinheiro", value: 70000),
          BarValue(category: "Pix", value: 300000),
        ]),
        BarGroup(label: "Out", values: [
          BarValue(category: "Dinheiro", value: 75000),
          BarValue(category: "Pix", value: 290000),
        ]),
        BarGroup(label: "Nov", values: [
          BarValue(category: "Dinheiro", value: 90000),
          BarValue(category: "Pix", value: 305000),
        ]),
        BarGroup(label: "Dez", values: [
          BarValue(category: "Dinheiro", value: 80000),
          BarValue(category: "Pix", value: 305000),
        ]),
      ];

      barGroups.assignAll(rawBarGroups);

    } catch (e) {
      debugPrint("Error loading chart data: $e");
    }
  }
}
