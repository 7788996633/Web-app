part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  
}

class LogEvent extends LoginEvent {
  final String email;
  final String password;

  LogEvent({required this.email, required this.password});
}
