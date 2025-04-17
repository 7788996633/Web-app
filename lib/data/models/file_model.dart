class FileModel {
  final int id;
  final String fileName;
  // final String filePath;
  final int status;
  // final int groupId;
  // final int userId;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  late final String fileType;

  FileModel({
    required this.id,
    required this.fileName,
    // required this.filePath,
    required this.status,
    // required this.groupId,
    // required this.userId,
    // required this.createdAt,
    // required this.updatedAt,
  }) {
    fileType = _extractFileType(fileName);
  }

  String _extractFileType(String fileName) {
    return fileName.split('.').last;
  }

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      fileName: json['fileName'],
      // filePath: json['filePath'],
      status: json['status'],
      // groupId: json['group_id'],
      // userId: json['user_id'],
      // createdAt: DateTime.parse(
      //   json['created_at'],
      // ),
      // updatedAt: DateTime.parse(
      //   json['updated_at'],
      // ),
    );
  }
}
