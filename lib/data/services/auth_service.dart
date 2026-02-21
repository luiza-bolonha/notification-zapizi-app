import 'package:dio/dio.dart';
import 'package:flutter_project_model/data/dto/response_login_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/login_dto.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: "http://localhost:8080")
abstract class AuthService {

  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/login')
  Future<ResponseLoginDTO> onLogin(@Body() LoginDTO body);
}