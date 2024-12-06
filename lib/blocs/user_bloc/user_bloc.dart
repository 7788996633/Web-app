import 'package:bloc/bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/data/repositories/user_repositories.dart';
import 'package:meta/meta.dart';

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
        }
      },
    );
  }
}
