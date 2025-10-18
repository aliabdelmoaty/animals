import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'api_interceptor.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {ApiConstants.contentType: ApiConstants.applicationJson},
      ),
    );

    _dio.interceptors.add(ApiInterceptor());
  }

  Dio get dio => _dio;
}
