class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});
  factory UserModel.fromJson(data) {
    return UserModel(
      id: data['id'],
      name: data['name'],
    );
  }
}
