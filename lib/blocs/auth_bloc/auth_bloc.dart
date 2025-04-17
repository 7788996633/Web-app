import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/data/services/register_services.dart';

import '../../data/services/login_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          emit(
            AuthLoading(),
          );
          try {
            String value =
                await LoginServices().login(event.email, event.password);
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
          } on Exception catch (e) {
            emit(
              AuthFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is RegisterEvent) {
          emit(
            AuthLoading(),
          );
          try {
            String value = await RegisterServices()
                .register(event.name, event.password, event.email);
            if (!value.contains('failed')) {
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
          } on Exception catch (e) {
            emit(
              AuthFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
