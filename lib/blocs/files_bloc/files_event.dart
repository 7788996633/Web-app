part of 'files_bloc.dart';

@immutable
sealed class FilesEvent {}

class UpLoadFile extends FilesEvent {
  final String fileName;
  final Uint8List fileBytes; // تغيير نوع البيانات إلى Uint8List
  final int groupID;

  UpLoadFile(
      {required this.fileName, required this.fileBytes, required this.groupID});
}

class FileCheckIn extends FilesEvent {
  final int fileId;

  FileCheckIn({required this.fileId});
}

class FileCheckOut extends FilesEvent {
  final int fileId;
  final String fileName;
  final Uint8List fileBytes;

  FileCheckOut({required this.fileId, required this.fileName, required this.fileBytes}); // تغيير نوع البيانات إلى Uint8List

}

class GetAllFiles extends FilesEvent {}

class GetGroupFiles extends FilesEvent {
  final int groupID;

  GetGroupFiles({required this.groupID});
}

class GetMyFiles extends FilesEvent {}

class GetLatestFiles extends FilesEvent {}

class DownLoadFile extends FilesEvent {
  final int fileId;

  DownLoadFile({required this.fileId});
}

class GetFileReports extends FilesEvent {
  final int fileId;

  GetFileReports({required this.fileId});
}
