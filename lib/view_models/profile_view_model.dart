import 'package:demo_login/models/reponse/profile_model.dart';
import 'package:demo_login/models/requests/login_request.dart';
import 'package:demo_login/services/services.dart';
import 'package:flutter/material.dart';

typedef OnErrorLogin = Function(String);
typedef OnUserPasswordNotFound = Function(String);
typedef OnSuccess = Function();
typedef OnLoading = Function();

class ProfileViewModel extends ChangeNotifier {
  late ProfileModel model;
  bool isLogin = false;
  bool isLoading = false;

  Future<void> login(
    LoginRequestModel modelRequest,
    OnErrorLogin onErrorLogin,
    OnUserPasswordNotFound onUserPasswordNotFound,
    OnLoading onLoading,
    OnSuccess onSuccess,
  ) async {
    onLoading();
    try {
      final result = await LoginServices().login(modelRequest);
      model = result;
      isLogin = true;
    } on UserPasswordNotFound catch (_) {
      onSuccess();
      onUserPasswordNotFound('OnUserPasswordNotFound');
    } on FormatException catch (_) {
      onSuccess();
      onErrorLogin('FormatException $_');
    } catch (e) {
      onSuccess();
      onErrorLogin('order error $e');
    } finally {
      notifyListeners();
    }
  }

  ProfileViewModel();
  String get email => model.email;
  String get name => model.name;
}
