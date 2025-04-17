import 'package:webapp/data/models/file_report_model.dart';

import '../models/file_model.dart';
import '../services/file_services.dart';

class FileRepositories {
  Future<List<FileModel>> getAllFiles() async {
    var fileList = await FileServices().getAllFiles();
    return fileList
        .map(
          (e) => FileModel.fromJson(e),
        )
        .toList();
  }

  Future<List<FileModel>> getMyFiles() async {
    var fileList = await FileServices().getMyFiles();
    return fileList
        .map(
          (e) => FileModel.fromJson(e),
        )
        .toList();
  }

  Future<List<FileModel>> getGroupFiles(int groupID) async {
    var fileList = await FileServices().getGroupFiles(groupID);
    return fileList
        .map(
          (e) => FileModel.fromJson(e),
        )
        .toList();
  }

  Future<List<FileReportModel>> getFileReports(int fileId) async {
    var reportList = await FileServices().getFileReports(fileId);
    return reportList
        .map(
          (e) => FileReportModel.fromJson(e),
        )
        .toList();
  }
}
