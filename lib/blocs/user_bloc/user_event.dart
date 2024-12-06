part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUsersListByGroupId extends UserEvent {
  final int groupId;

  GetUsersListByGroupId({required this.groupId});
}

class GetAllUsers extends UserEvent {}
