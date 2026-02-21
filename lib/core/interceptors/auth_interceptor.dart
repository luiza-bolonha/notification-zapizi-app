import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../storage/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final StorageService storage = Get.find();

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await storage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await storage.getRefreshToken();

        if (refreshToken == null) {
          return handler.next(err);
        }

        final response = await dio.post(
          '/auth/refresh',
          data: {
            "refreshToken": refreshToken,
          },
        );

        final newToken = response.data['accessToken'];
        final newRefresh = response.data['refreshToken'];

        await storage.saveToken(newToken);
        await storage.saveRefreshToken(newRefresh);

        final requestOptions = err.requestOptions;

        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final cloneResponse = await dio.fetch(requestOptions);

        return handler.resolve(cloneResponse);
      } catch (e) {
        await storage.clearAuth();
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}