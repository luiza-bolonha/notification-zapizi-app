import 'package:flutter/material.dart';
import 'package:flutter_project_model/modules/auth/controller/auth_controller.dart';
import 'package:flutter_project_model/modules/home/controller/home_controller.dart';
import 'package:flutter_project_model/modules/home/widget/custom_bar_chart.dart';
import 'package:flutter_project_model/modules/home/widget/custom_pie_chart.dart';
import 'package:get/get.dart';

import '../data/bar_category.dart';
import '../data/bar_group.dart';
import '../data/bar_value.dart';
import '../data/pie_chart_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();
  final store = Get.find<AuthController>();
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                homeController.isDark.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                homeController.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
            Obx(() {
              if (homeController.pieData.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomPieChart(data: homeController.pieData.toList());
            }),
            const SizedBox(height: 32),
            Obx(() {
              if (homeController.barGroups.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomBarChart(
                title: 'Faturamento por Meio de Pagamento',
                categories: homeController.barCategories.toList(),
                groups: homeController.barGroups.toList(),
              );
            }),
          ],
        ),
      ),
    ),
  );
}
}
