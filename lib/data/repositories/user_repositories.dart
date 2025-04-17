import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/data/services/user_services.dart';

class UserRepositories {
  Future<List<UserModel>> getUsersByGroupId(int groupId) async {
    var usersList = await UserServices().getUsersByGroupId(groupId);
    return usersList
        .map(
          (e) => UserModel.fromJson(e),
        )
        .toList();
  }

  Future<List<UserModel>> getAllUsers() async {
    var usersList = await UserServices().getAllUsers();
    return usersList
        .map(
          (e) => UserModel.fromJson(e),
        )
        .toList();
  }

  Future<List<UserModel>> getUsersNotInGroup(int groupID) async {
    var usersList = await UserServices().getUsersNotInGroup(groupID);
    return usersList
        .map(
          (e) => UserModel.fromJson(e),
        )
        .toList();
  }
}
