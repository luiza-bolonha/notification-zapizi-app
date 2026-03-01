import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/dto/login_dto.dart';

class HomeController extends GetxController {
  final StorageService _storageService = Get.put(StorageService());
  
  final RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    isDark.value = await _storageService.isDarkTheme();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    _storageService.saveTheme(isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
