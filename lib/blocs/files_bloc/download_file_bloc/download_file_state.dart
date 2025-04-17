part of 'download_file_bloc.dart';

@immutable
sealed class DownloadFileState {}

final class DownloadFileInitial extends DownloadFileState {}

final class DownloadFileLoading extends DownloadFileState {}

final class DownloadFileSuccess extends DownloadFileState {
  final String successmsg;

  DownloadFileSuccess({required this.successmsg});
}

final class DownloadFileFail extends DownloadFileState {
  final String errmsg;

  DownloadFileFail({required this.errmsg});
}
