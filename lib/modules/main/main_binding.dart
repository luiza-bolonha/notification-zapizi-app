import 'package:dio/dio.dart';
import 'package:flutter_project_model/data/services/auth_service.dart';
import 'package:flutter_project_model/modules/auth/controller/auth_controller.dart';
import 'package:flutter_project_model/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

import '../../core/interceptors/auth_interceptor.dart';
import '../../core/storage/storage_service.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);

    final dio = Dio();
    dio.options.baseUrl = "http://localhost:8080";
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(AuthInterceptor(dio));

    Get.put<Dio>(dio);

    Get.put<AuthService>(AuthService(dio));

    Get.put<AuthRepository>(AuthRepository(Get.find<AuthService>()));

    Get.lazyPut(() => AuthController(), /*fenix: true*/);
  }
}