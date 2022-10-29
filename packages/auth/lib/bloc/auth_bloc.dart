import 'package:api/api.dart';
import 'package:auth/keys.dart';
import 'package:auth/models/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.init()) {
    on<AuthEventInit>((event, emit) async {
      await event.init?.call();
      if (kDebugMode) await Future.delayed(const Duration(seconds: 2));
      final onboaring = await Pref.getBoolF(Keys.onbroaring);
      if (onboaring) {
        emit(state.copyWith(taskApp: TaskApp.onBoaringFinish));
      } else {
        emit(state.copyWith(
          taskApp: TaskApp.onBoaringDoing1,
          isInit: true,
        ));
        return;
      }
      final tokenF = await Pref.getStringF(Keys.accessToken);
      final auth =
          tokenF != null ? AuthModel.fromJson(Jwt.parseJwt(tokenF)) : null;
      final isLogin = tokenF != null
          ? DateTime(1970, 1, 1)
              .add(Duration(seconds: auth?.ext ?? 0))
              .isAfter(DateTime.now())
          : false;
      emit(state.copyWith(
        auth: auth,
        taskApp: isLogin ? TaskApp.login : TaskApp.unLogin,
        isInit: true,
      ));
    });
    on<AuthEventOnBoaringFinish>(
      (event, emit) => emit(state.copyWith(taskApp: TaskApp.onBoaringFinish)),
    );
    on<AuthEventOnBoaringDoing>(
      (event, emit) {
        if (event.step.isBoaringDoing1 ||
            event.step.isBoaringDoing2 ||
            event.step.isBoaringDoing3 ||
            event.step.isBoaringDoing4) {
          emit(state.copyWith(taskApp: event.step));
        }
      },
    );
    on<AuthEventUnAuthenticated>(
      (event, emit) => emit(state.copyWith(taskApp: TaskApp.unLogin)),
    );
  }
}
