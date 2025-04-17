part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserSuccess extends UserState {
  final String successmsg;

  UserSuccess({required this.successmsg});
}

final class UserLoading extends UserState {}

final class UserFail extends UserState {
  final String errmsg;

  UserFail({required this.errmsg});
}

final class UsersListLoaded extends UserState {
  final List<UserModel> usersList;

  UsersListLoaded({required this.usersList});
}

final class UserInfoByIdLoaded extends UserState {
  final UserModel userModel;

  UserInfoByIdLoaded({required this.userModel});
}

final class UserRoleIsAdmin extends UserState {}

final class UserRoleIsMember extends UserState {}
