import 'package:webapp/data/models/group_model.dart';
import 'package:webapp/data/services/group_services.dart';

class GroupRepositories {
  Future<List<GroupModel>> getAllGroups() async {
    var groupList = await GroupServices().getAllGroups();
    return groupList
        .map(
          (e) => GroupModel.fromJson(e),
        )
        .toList();
  }

  Future<List<GroupModel>> getSharedGroups(int userId) async {
    var groupList = await GroupServices().getSharedGroups(userId);
    return groupList
        .map(
          (e) => GroupModel.fromJson(e),
        )
        .toList();
  }
}
