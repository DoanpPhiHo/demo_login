part of '../services.dart';

abstract class ILoginServices {
  Future<ProfileModel> login(LoginRequestModel model);
}
