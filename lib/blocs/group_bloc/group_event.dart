part of 'group_bloc.dart';

@immutable
sealed class GroupEvent {}

class CreateGroup extends GroupEvent {
  final String groupName;
  final String desc;

  CreateGroup({required this.groupName, required this.desc});
}

class AddUserToGroup extends GroupEvent {
  final int groupId;
  final int userId;

  AddUserToGroup({required this.groupId, required this.userId});
}

class GetAllGroups extends GroupEvent {}

class GetSharedGroups extends GroupEvent {
  final int userId;

  GetSharedGroups({required this.userId});
}

class CreateGroupWithUser extends GroupEvent {
  final String groupName;
  final int userId;

  CreateGroupWithUser({required this.groupName, required this.userId});
}
