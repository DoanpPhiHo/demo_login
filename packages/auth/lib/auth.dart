library auth;

import 'dart:async';
import 'dart:developer';

import 'package:api/api.dart' show Pref;
import 'package:auth/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'keys.dart';

export 'bloc/auth_bloc.dart';

typedef UnAuthenticated = void Function();

abstract class IAuthFunction {
  Future<void> init(UnAuthenticated func);
  Future<void> refreshToken(UnAuthenticated func);
  Future<void> replaceToken(AuthModel auth);
  Future<void> logout(UnAuthenticated func);
  Future<bool> accountLogin(String username, String password);
  Future<void> getAppId();
}

class AuthFunction extends IAuthFunction {
  AuthFunction._();

  static final AuthFunction instance = AuthFunction._();

  void onBoaringFinish(BuildContext context) {
    Pref.setBool(Keys.onbroaring, true).catchError((e) {
      log(e.toString());
    });
    context.read<AuthBloc>().add(AuthEventOnBoaringFinish());
  }

  void onBoaringDoing(
    BuildContext context, {
    required TaskApp step,
  }) =>
      context.read<AuthBloc>().add(AuthEventOnBoaringDoing(step));

  void onUnAuthen(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventUnAuthenticated());
  }

  String? get tokenBuyer => _token;

  String? _token;

  int counterRetry = 0;

  @override
  Future<void> init(UnAuthenticated func) async {
    final refreshTokenStr = await Pref.getStringF(Keys.refreshToken);
    await getAppId();

    if (refreshTokenStr != null && refreshTokenStr.isNotEmpty) {
      await refreshToken(func);
    }
  }

  @override
  Future<void> refreshToken(UnAuthenticated func) async {
    // final _refreshToken = await Pref.getStringF(Keys.SE_PREF_REFRESH_TOKEN);
    // var _param = {'refresh_token': _refreshToken};
    // final _resultApi = await AuthAPI.instance.refreshToken(data: _param);
    // await _resultApi.fold<Future>((l) async {
    //   return throw const AuthenException(
    //       message: "Phiên đăng nhập hết hạn", type: AuthenErrorType.logout);
    // }, (r) async {
    //   final _auth = AuthenEntity.fromJson(r.data);
    //   await replaceToken(_auth);
    // });
    /// if not refresh token => call func
  }

  @override
  Future<void> replaceToken(AuthModel auth) async {
    // if (_auth.refreshToken != null) {
    //   await Pref.setString(Keys.SE_PREF_REFRESH_TOKEN, _auth.refreshToken!);
    //   LogHelper.print("newRefreshToken", _auth.refreshToken);
    // }
    // if (_auth.accessToken != null) {
    //   await Pref.setString(Keys.USER_ID, _auth.userId!);
    //   _token = _auth.accessToken;
    //   await NotificationHelper.instance.uploadFCM();
    // }
    // // await VuiVuiRequest.instance.init(header: {
    // //   'Authorization': 'Bearer ${_auth.accessToken}',
    // // });
  }

  @override
  Future<void> logout(UnAuthenticated func) async {
    try {
      await Pref.clear();
      await init(func);
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Future<bool> accountLogin(String username, String password) async {
    return false;
    // var data = {
    //   'email_or_phone_number': username,
    //   'password': password,
    // };
    // return await (await AuthAPI.instance.accountLogin(data: data))
    //     .fold<Future<bool>>(
    //   (l) async {
    //     log('error guest login ${l.messenges} ::: ${l.status}');
    //     throw Exception(l.messenges);
    //     // return false;
    //   },
    //   (r) async {
    //     final _auth = AuthenEntity.fromJson(r.data);
    //     await Pref.remove(PrefKeys.PREF_CART_ID);
    //     LogHelper.print("accountLogin : ", r.data);

    //     if (_auth.error == '-88') {
    //       throw UserPasswordNotFoundRegister('-88');
    //     }
    //     if (_auth.error == 'invalid_grant') {
    //       throw UserNotRegister('invalid_grant');
    //     }

    //     await replaceToken(_auth);
    //     return true;
    //   },
    // );
  }

  @override
  Future<void> getAppId() async {
    // String? appId = await Pref.getStringF(Keys.SE_PREF_APP_ID);
    // String? signature = await Pref.getStringF(Keys.SE_PREF_SIGNATURE);
    // String? userId = await Pref.getStringF(Keys.SE_PREF_USER_ID);
    // String? appVersion = await Pref.getStringF(Keys.SE_PREF_VERSION);

    // if (appId == null || signature == null || userId == null) {
    //   String newGenAppId = ObjectId().hexString;
    //   String? firebaseToken;
    //   try {
    //     firebaseToken = await FirebaseMessaging.instance.getToken();
    //   } catch (error) {
    //     firebaseToken = "";
    //     rethrow;
    //   }
    //   var _param = {
    //     Keys.APP_ID: newGenAppId,
    //     Keys.FIREBASE_TOKEN: firebaseToken,
    //   };
    //   final _resultAPI = await AuthAPI.instance.registerAppID(data: _param);
    //   await _resultAPI.fold<Future>(
    //     (l) async {
    //       return throw AuthenException(
    //           message: "Register AppId Fail \n ${l.messenges} ");
    //       // if (counterRetry == 5) {
    //       //   Fluttertoast.showToast(
    //       //     msg: 'Đóng app do cố gắng kết nối với máy chủ nhiều lần',
    //       //     toastLength: Toast.LENGTH_LONG,
    //       //   );
    //       //   exit(0);
    //       // }
    //       // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //       //   Fluttertoast.showToast(
    //       //     msg: 'Retry get appid in ${(6 - timer.tick)}',
    //       //     toastLength: Toast.LENGTH_LONG,
    //       //   );
    //       //   if (timer.tick == 5) {
    //       //     counterRetry += 1;
    //       //     timer.cancel();
    //       //   }
    //       // });
    //       // await Future.delayed(const Duration(seconds: 5), () async {
    //       //   await AuthFunction.instance.getAppId();
    //       // });
    //     },
    //     (r) async {
    //       counterRetry = 0;
    //       if (!r.isError! && r.data != null) {
    //         final _appID = AppIdEntity.fromJson(r.data);
    //         await Pref.setString(Keys.SE_PREF_APP_ID, _appID.appId!);
    //         await Pref.setString(Keys.SE_PREF_SIGNATURE, _appID.signature!);
    //         await Pref.setString(Keys.SE_PREF_USER_ID, _appID.userId!);
    //         await Pref.setString(Keys.SE_PREF_VERSION, '1');
    //         var _paramHeader = {
    //           'vv-app-id': _appID.appId!,
    //           'vv-app-version': '1',
    //           'vv-app-signature': _appID.signature!,
    //         };
    //         await ApiRequest.instance.init(header: _paramHeader);
    //       }
    //     },
    //   );
    // } else {
    //   var paramHeader = {
    //     'vv-app-id': appId,
    //     'vv-app-version': appVersion,
    //     'vv-app-signature': signature,
    //   };
    //   await ApiRequest.instance.init(header: paramHeader);
    // }
  }
}
