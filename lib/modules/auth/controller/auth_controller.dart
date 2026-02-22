import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_model/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

import '../../../data/dto/login_dto.dart';
import '../../../global/snackbar.dart';

class AuthController extends GetxController{

  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;
  bool get obscurePassword => _obscurePassword.value;
  var isLoading = false.obs;

  void onChangeObscure() => _obscurePassword.value = !_obscurePassword.value;

  final repo = Get.find<AuthRepository>();

  Future<void> login() async {
    if(loginController.text == '' || passwordController.text == ''){
      snackBar("Necessário informar Login e Senha");
    } else {
      try {
        isLoading.value = true;
        var body = LoginDTO(
            login: loginController.text, password: passwordController.text);
        await repo.login(body);
        isLoading.value = false;
        // Get.toNamed(MainRoutes.home);
      } on DioException catch (e) {
        isLoading.value = false;
        snackBar(e.response?.data['message'] ?? "Erro ao realizar login");
      }
    }
  }
}