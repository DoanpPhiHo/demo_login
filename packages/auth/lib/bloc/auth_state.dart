part of 'auth_bloc.dart';

enum TaskApp {
  init,
  onBoaringDoing1,
  onBoaringDoing2,
  onBoaringDoing3,
  onBoaringDoing4,
  onBoaringFinish,
  login,
  unLogin,
}

extension TaskAppValue on TaskApp {
  bool get isInit => this == TaskApp.init;
  bool get isBoaringDoing1 => this == TaskApp.onBoaringDoing1;
  bool get isBoaringDoing2 => this == TaskApp.onBoaringDoing2;
  bool get isBoaringDoing3 => this == TaskApp.onBoaringDoing3;
  bool get isBoaringDoing4 => this == TaskApp.onBoaringDoing4;
  bool get isBoaringFinish => this == TaskApp.onBoaringFinish;
  bool get isLogin => this == TaskApp.login;
  bool get isUnLogin => this == TaskApp.unLogin;
}

class AuthState {
  final AuthModel auth;

  final TaskApp taskApp;
  final bool isInit;

  AuthState({
    required this.auth,
    required this.taskApp,
    required this.isInit,
  });
  factory AuthState.init() => AuthState(
        auth: AuthModel(),
        taskApp: TaskApp.init,
        isInit: false,
      );
  AuthState copyWith({
    AuthModel? auth,
    TaskApp? taskApp,
    bool? isInit,
  }) =>
      AuthState(
        isInit: isInit ?? this.isInit,
        auth: auth ?? this.auth,
        taskApp: taskApp ?? this.taskApp,
      );
}
