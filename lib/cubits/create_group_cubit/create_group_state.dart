part of 'create_group_cubit.dart';

@immutable
sealed class CreateGroupState {}

final class CreateGroupInitial extends CreateGroupState {}

final class CreateGroupSuccess extends CreateGroupState {
  final String successmsg;

  CreateGroupSuccess({required this.successmsg});
}

final class CreateGroupFail extends CreateGroupState {
  final String errmsg;

  CreateGroupFail({required this.errmsg});
}

final class CreateGroupLoading extends CreateGroupState {}
