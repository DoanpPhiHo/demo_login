import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../helper/log_helper.dart';
import '../helper/network_helper.dart';
import 'dio_interceptor.dart';
import 'models/device_info.dart';

const String tagError = '[DIO - ERROR] - ';

typedef RefreshTokenFunc = Future<void> Function();

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
    required this.connectionChecker,
    this.refreshTokenFunc,
    required this.baseUrl,
  });
  final DioConnectivityRequestRetrier requestRetrier;
  final Connectivity connectionChecker;
  final RefreshTokenFunc? refreshTokenFunc;
  final String baseUrl;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final error = err.requestOptions;
    final DeviceInfo deviceInfo = await DeviceInfo.getDeviceInfo();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    LogHelper.error(tagError, """
    TYPE       ====> ${err.type.name}
    URL        ====> ${error.baseUrl}${error.path}
    STATUS     ====> ${err.response?.statusCode}
    HEADER     ====> ${error.headers}
    TOKEN      ====> ${error.headers['Authorization']}
    BODY       ====> ${error.data}
    QUERYPARAM ====> ${error.queryParameters}
    RESPONSE   ====> ${err.response}
    """);

    final isNetworkAvailable = await NetworkHelper.instance.checkConnection();

    if (!isNetworkAvailable) {
      return handler.resolve(
        await requestRetrier.scheduleRequestRetry(
          err.requestOptions,
          connectionChecker: connectionChecker,
        ),
      );
    } else {
      /// report log ==> api
      log("""
            deviceId : ${deviceInfo.deviceId}
            deviceInfo : ${deviceInfo.deviceName}
            deviceVersion : ${deviceInfo.deviceVersion}
            appVersion : ${packageInfo.version}
            buildNumber : ${packageInfo.buildNumber}
            modelName: ${deviceInfo.modelName},
            method : ${err.requestOptions.method}
            status code : ${err.response?.statusCode}
            base url: : ${error.baseUrl}${error.path}
            appId : ${error.headers['vv-app-id']}
            signature : ${error.headers['vv-app-signature']}
            data request: : ${error.data.toString()}'
            parameters request: : ${error.queryParameters.toString()}',
            response: : ${err.response.toString()}'
          
        """);
    }

    if (err.response?.statusCode == 401 && err.response?.data == null) {
      await refreshTokenFunc?.call();
      err.requestOptions.baseUrl = baseUrl;
      return handler.resolve(
        await requestRetrier.retryResponseWhenExpired(err.requestOptions),
      );
    }

    final response = Response(
      data: 'SERVER_ERROR',
      requestOptions: err.requestOptions,
    );

    return handler.resolve(err.response ?? response);
  }
}
