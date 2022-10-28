part of 'services.dart';

const dynamic fakeReponse = {
  "name": "doan ho",
  "email": "doanho.it.dev@gmail.com",
};

class IUserPasswordNotFound implements Exception {
  const IUserPasswordNotFound(this.msg);
  final String? msg;
}

class UserPasswordNotFound extends IUserPasswordNotFound {
  const UserPasswordNotFound([String? msg]) : super(msg);
}

class LoginServices {
  Future<ProfileModel> login(LoginRequestModel model) async {
    await Future.delayed(const Duration(seconds: 2));
    if (model.email == 'hello@example.com' && model.password == '123456') {
      try {
        return ProfileModel.fromJson(fakeReponse as Map<String, dynamic>);
      } catch (_) {
        throw FormatException(_.toString());
      }
    }
    throw const UserPasswordNotFound('UserPasswordNotFound');
  }
}
