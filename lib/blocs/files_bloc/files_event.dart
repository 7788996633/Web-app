part of 'files_bloc.dart';

@immutable
sealed class FilesEvent {}

class UpLoadFile extends FilesEvent {
  final String fileName;
  final String filePath;

  UpLoadFile({required this.fileName, required this.filePath});
}

class FileCheckIn extends FilesEvent {
  final int fileId;

  FileCheckIn({required this.fileId});
}

class FileCheckOut extends FilesEvent {
  final int fileId;

  FileCheckOut({required this.fileId});
}

class GetAllFiles extends FilesEvent {}

class GetLatestFiles extends FilesEvent {}

class DownLoadFile extends FilesEvent {
  final int fileId;

  DownLoadFile({required this.fileId});
}

class GetFileReports extends FilesEvent {
  final int fileId;

  GetFileReports({required this.fileId});
}
