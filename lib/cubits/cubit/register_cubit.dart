import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/data/services/register_services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  void register(String email, String password, String name) async {
    emit(
      RegisterLoading(),
    );
    try {
      String value = await RegisterServices().register(name, password, email);
      if (value != 'fail') {
        emit(
          RegisterSuccess(
            token: value,
          ),
        );
      } else {
        emit(
          RegisterFail(
            errmsg: value,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        RegisterFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
