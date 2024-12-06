part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({required this.token});
}

final class LoginLoading extends LoginState {}

final class LoginFail extends LoginState {
  final String errmsg;

  LoginFail({required this.errmsg});
}
