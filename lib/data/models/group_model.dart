class GroupModel {
  final int id;
  final String groupName;

  GroupModel({
    required this.id,
    required this.groupName,
  });

  factory GroupModel.fromJson(data) {
    return GroupModel(
      id: data['group_id'],
      groupName: data['group_name'],
    );
  }
}
