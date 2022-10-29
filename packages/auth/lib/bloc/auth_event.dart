part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventInit extends AuthEvent {
  final Future<void> Function()? init;

  AuthEventInit({this.init});
}

class AuthEventOnBoaringFinish extends AuthEvent {}

class AuthEventOnBoaringDoing extends AuthEvent {
  final TaskApp step;

  AuthEventOnBoaringDoing(this.step);
}

class AuthEventUnAuthenticated extends AuthEvent {}
