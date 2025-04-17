part of 'download_file_bloc.dart';

@immutable
sealed class DownloadFileEvent {}
class DownLoadFiles extends DownloadFileEvent{
  final int fileID;

  DownLoadFiles({required this.fileID});
}