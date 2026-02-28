import 'package:flutter/material.dart';
import 'package:flutter_project_model/modules/auth/controller/auth_controller.dart';
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


  final categories = [
    BarCategory(name: "Dinheiro", color: Colors.green),
    BarCategory(name: "Pix", color: Colors.amber),
    BarCategory(name: "Venda Manual", color: Colors.cyan),
    BarCategory(name: "Crédito", color: Colors.red),
    BarCategory(name: "Débito", color: Colors.grey),
  ];

  final data = [
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
  ];
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
            CustomBarChart(
              categories: categories,
              groups: data,
            )
          ],
        ),
      ),
    );
  }
}
