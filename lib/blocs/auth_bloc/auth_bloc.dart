import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/services/login_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(
          AuthLoading(),
        );
        try {
          LoginServices().login(event.email, event.password).then((value) {
            if (value != 'fail') {
              emit(
                AuthSuccess(
                  token: value,
                ),
              );
            } else {
              emit(
                AuthFail(
                  errmsg: value,
                ),
              );
            }
          });
        } on Exception catch (e) {
          emit(
            AuthFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
