library api;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptor/dio_interceptor.dart';
import 'interceptor/retry_interceptor.dart';

part 'helper/pref.dart';

class ApiRequest {
  ApiRequest._();

  static final ApiRequest instance = ApiRequest._();

  final Dio _dio = Dio();

  Dio get dioClient => _dio;

  Future<void> init({
    Map<String, dynamic>? header,
    required String baseUrl,
    RefreshTokenFunc? refreshTokenFunc,
  }) async {
    _dio.options.baseUrl = baseUrl;
    if (header != null) {
      for (final kv in header.entries) {
        _dio.options.headers[kv.key] = kv.value;
      }
    }
    if (baseUrl != _dio.options.baseUrl) _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 20000;
    _dio.options.receiveTimeout = 20000;
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        baseUrl: baseUrl,
        requestRetrier: DioConnectivityRequestRetrier(dio: _dio),
        connectionChecker: Connectivity(),
        refreshTokenFunc: refreshTokenFunc,
      ),
    );
  }
}
