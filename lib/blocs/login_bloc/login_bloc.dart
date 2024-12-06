import 'package:bloc/bloc.dart';
import 'package:webapp/data/services/login_services.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LogEvent) {
        emit(
          LoginLoading(),
        );
        try {
          LoginServices().login(event.email, event.password).then((value) {
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
    });
  }
}
