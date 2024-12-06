part of 'group_bloc.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupSuccess extends GroupState {
  final String successmsg;

  GroupSuccess({required this.successmsg});
}

final class GroupLoading extends GroupState {}

final class GroupFail extends GroupState {
  final String errmsg;

  GroupFail({required this.errmsg});
}

final class GroupListLoaded  extends GroupState {
  final List<GroupModel> groupList;

  GroupListLoaded ({required this.groupList});
}
