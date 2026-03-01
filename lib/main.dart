import 'package:flutter/material.dart';
import 'package:flutter_project_model/style/app_theme.dart';
import 'package:get/get.dart';

import 'core/storage/storage_service.dart';
import 'modules/main/main_binding.dart';
import 'modules/main/main_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create and use StorageService to find out initial theme state
  final storageService = Get.put(StorageService());
  final isDark = await storageService.isDarkTheme();

  runApp(MyApp(
    initialThemeMode: isDark ? ThemeMode.dark : ThemeMode.light,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeMode initialThemeMode;

  const MyApp({
    super.key,
    required this.initialThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: initialThemeMode,
      initialBinding: MainBinding(),
      initialRoute: MainRoutes.auth,
      getPages: getPages,
    );
  }
}
