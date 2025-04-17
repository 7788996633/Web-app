import 'package:bloc/bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/data/repositories/user_repositories.dart';
import 'package:meta/meta.dart';
import 'package:webapp/data/services/user_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>(
      (event, emit) async {
        if (event is GetUsersListByGroupId) {
          emit(
            UserLoading(),
          );
          try {
            List<UserModel> value =
                await UserRepositories().getUsersByGroupId(event.groupId);
            emit(
              UsersListLoaded(
                usersList: value,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetUserById) {
          emit(
            UserLoading(),
          );
          try {
            UserModel value = await UserServices().getUserById(event.userId);
            if (value.id != -1) {
              emit(
                UserInfoByIdLoaded(
                  userModel: value,
                ),
              );
            } else {
              emit(
                UserFail(
                  errmsg: 'Something went wrong',
                ),
              );
            }
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllUsers) {
          emit(
            UserLoading(),
          );
          try {
            List<UserModel> value = await UserRepositories().getAllUsers();
            emit(
              UsersListLoaded(
                usersList: value,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetUsersNotInGroup) {
          emit(
            UserLoading(),
          );
          try {
            List<UserModel> value =
                await UserRepositories().getUsersNotInGroup(event.groupID);
            emit(
              UsersListLoaded(
                usersList: value,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetUserRole) {
          emit(
            UserLoading(),
          );
          try {
            String role =
                await UserServices().getUserRoleInGroup(event.groupId);
              if (role == 'owner') {
                emit(
                  UserRoleIsAdmin(),
                );
              } else if (role == 'user') {
                emit(
                  UserRoleIsMember(),
                );
              } else {
                emit(
                  UserFail(
                    errmsg: role,
                  ),
                );
              }
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
