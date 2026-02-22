import 'package:flutter/material.dart';
import 'package:flutter_project_model/modules/auth/controller/auth_controller.dart';
import 'package:flutter_project_model/modules/home/widget/custom_bar_chart.dart';
import 'package:flutter_project_model/modules/home/widget/custom_pie_chart.dart';
import 'package:get/get.dart';

import '../data/pie_chart_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();
  final store = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomPieChart(
              data: [
                PieChartItem(
                  label: "Shopping Vitória",
                  value: 500,
                ),
                PieChartItem(
                  label: "Shopping Vila Velha",
                  value: 400,
                ),
                PieChartItem(
                  label: "Loja Marechal",
                  value: 300,
                ),
                PieChartItem(
                  label: "Moxuara Loja",
                  value: 200,
                ),
                PieChartItem(
                  label: "Shopping Mestre Álvaro",
                  value: 500,
                ),
              ],
            ),
            CustomBarChart()
          ],
        ),
      ),
    );
  }
}
