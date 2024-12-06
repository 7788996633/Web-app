class FileReportModel {
  final String userName;
  final DateTime dateTime;
  final String action;

  FileReportModel(
      {required this.userName, required this.dateTime, required this.action});

  factory FileReportModel.fromJson(data) {
    return FileReportModel(
      userName: data['user_name'],
      dateTime: DateTime.parse(
        data['created_at'],
      ),
      action: data['status'],
    );
  }
}
