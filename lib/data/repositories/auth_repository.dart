import 'package:flutter_project_model/data/dto/response_login_dto.dart';
import 'package:flutter_project_model/data/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/storage/storage_service.dart';
import '../dto/login_dto.dart';

class AuthRepository{
  final AuthService service;

  AuthRepository(this.service);

  final storage = Get.find<StorageService>();

  Future<ResponseLoginDTO> login(LoginDTO body) async {
    final response = await service.onLogin(body);

    await storage.saveToken(response.accessToken);
    await storage.saveRefreshToken(response.refreshToken);

    return response;
  }
}