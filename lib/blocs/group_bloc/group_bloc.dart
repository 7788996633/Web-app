import 'package:bloc/bloc.dart';
import 'package:webapp/data/models/group_model.dart';
import 'package:webapp/data/repositories/group_repositories.dart';
import 'package:webapp/data/services/group_services.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial()) {
    on<GroupEvent>((event, emit) async {
      if (event is CreateGroup) {
        emit(
          GroupLoading(),
        );
        try {
          String value =
              await GroupServices().createGroup(event.groupName, event.desc);
          emit(
            GroupSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is CreateGroupWithUser) {
        emit(
          GroupLoading(),
        );
        try {
          String value = await GroupServices()
              .createGroupWithUser(event.userId, event.groupName);
          emit(
            GroupSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetAllGroups) {
        emit(
          GroupLoading(),
        );
        try {
          List<GroupModel> value = await GroupRepositories().getAllGroups();
          emit(
            GroupListLoaded(
              groupList: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is AddUserToGroup) {
        emit(
          GroupLoading(),
        );
        try {
          String value =
              await GroupServices().addUserToGroup(event.groupId, event.userId);
          emit(
            GroupSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is DeleteFileFromGroup) {
        emit(
          GroupLoading(),
        );
        try {
          String value = await GroupServices()
              .deleteFileFromGroup(event.groupId, event.fileId);
          emit(
            GroupSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is DeleteUserFromGroup) {
        emit(
          GroupLoading(),
        );
        try {
          String value = await GroupServices()
              .deleteUserFromGroup(event.groupId, event.userId);
          emit(
            GroupSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetSharedGroups) {
        emit(
          GroupLoading(),
        );
        try {
          List<GroupModel> value =
              await GroupRepositories().getSharedGroups(event.userId);
          emit(
            GroupListLoaded(
              groupList: value,
            ),
          );
        } catch (e) {
          emit(
            GroupFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
