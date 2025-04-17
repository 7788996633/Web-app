part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String token;

  RegisterSuccess({required this.token});
}

final class RegisterFail extends RegisterState {
  final String errmsg;

  RegisterFail({required this.errmsg});
}
