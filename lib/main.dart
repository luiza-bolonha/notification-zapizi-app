import 'package:flutter/material.dart';
import 'package:flutter_project_model/style/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'modules/main/main_binding.dart';
import 'modules/main/main_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      initialBinding: MainBinding(),
      initialRoute: MainRoutes.auth,
      getPages: getPages,
    );
  }
}
