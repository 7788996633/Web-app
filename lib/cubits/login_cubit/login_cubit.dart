import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/services/login_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) {
    emit(
      LoginLoading(),
    );
    try {
      LoginServices().login(email, password).then((value) {
        if (value != 'fail') {
          emit(
            LoginSuccess(
              token: value,
            ),
          );
        } else {
          emit(
            LoginFail(
              errmsg: value,
            ),
          );
        }
      });
    } on Exception catch (e) {
      emit(
        LoginFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
