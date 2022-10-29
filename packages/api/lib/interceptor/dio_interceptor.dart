import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  DioConnectivityRequestRetrier({required this.dio});
  final Dio dio;

  Future<Response> retryResponseWhenExpired(
      RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    responseCompleter.complete(
      dio.request(
        requestOptions.path,
        cancelToken: requestOptions.cancelToken,
        data: requestOptions.data,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
        queryParameters: requestOptions.queryParameters,
      ),
    );
    return responseCompleter.future;
  }

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions,
      {required Connectivity connectionChecker}) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectionChecker.onConnectivityChanged.listen(
      (connectivityResult) {
        // debugPrint('------------ Retry request error ------------');
        // debugPrint('connectivity result: ========> $connectivityResult');
        // debugPrint('path: ========> ${requestOptions.path}');
        // // debugPrint('header: ========> ${requestOptions.headers}');
        // log('header: ========> ${requestOptions.headers}');
        // debugPrint('data request: ========> ${requestOptions.data.toString()}');
        // debugPrint(
        //   'parameters request: ========> ${requestOptions.queryParameters.toString()}',
        // );
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );
        }
      },
    );
    return responseCompleter.future;
  }

  Future<Response> retryRequestWhenExpire(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();

    responseCompleter.complete(
      dio.request(
        requestOptions.path,
        cancelToken: requestOptions.cancelToken,
        data: requestOptions.data,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
        queryParameters: requestOptions.queryParameters,
      ),
    );
    return responseCompleter.future;
  }
}
