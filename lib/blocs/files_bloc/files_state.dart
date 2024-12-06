part of 'files_bloc.dart';

@immutable
sealed class FilesState {}

final class FilesInitial extends FilesState {}

final class FilesSuccess extends FilesState {
  final String successmsg;

  FilesSuccess({required this.successmsg});
}

final class FilesLoading extends FilesState {}

final class FilesFail extends FilesState {
  final String errmsg;

  FilesFail({required this.errmsg});
}

final class FilesListLoaded extends FilesState {
  final List<FileModel> filesList;

  FilesListLoaded({required this.filesList});
}

final class FileReportsListLoaded extends FilesState {
  final List<FileReportModel> reportsList;

  FileReportsListLoaded({required this.reportsList});
}
