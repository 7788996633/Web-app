part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUsersListByGroupId extends UserEvent {
  final int groupId;

  GetUsersListByGroupId({required this.groupId});
}

class GetAllUsers extends UserEvent {}

class GetUsersNotInGroup extends UserEvent {
  final int groupID;

  GetUsersNotInGroup({required this.groupID});
}

class GetUserById extends UserEvent {
  final int userId;

  GetUserById({required this.userId});
}

class GetUserRole extends UserEvent {
  final int groupId;

  GetUserRole({required this.groupId});
}
