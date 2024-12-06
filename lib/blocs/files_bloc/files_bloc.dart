import 'package:bloc/bloc.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/data/repositories/file_repositories.dart';
import 'package:webapp/data/services/file_services.dart';
import 'package:meta/meta.dart';

import '../../data/models/file_report_model.dart';

part 'files_event.dart';
part 'files_state.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  FilesBloc() : super(FilesInitial()) {
    on<FilesEvent>((event, emit) async {
      if (event is UpLoadFile) {
        emit(
          FilesLoading(),
        );
        try {
          String value =
              await FileServices().upLoadFile(event.fileName, event.filePath);
          emit(
            FilesSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is DownLoadFile) {
        emit(
          FilesLoading(),
        );
        try {
          String value = await FileServices().downLoadFile(event.fileId);
          emit(
            FilesSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is FileCheckIn) {
        emit(
          FilesLoading(),
        );
        try {
          String value = await FileServices().checkIn(event.fileId);
          emit(
            FilesSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is FileCheckOut) {
        emit(
          FilesLoading(),
        );
        try {
          String value = await FileServices().checkOut(event.fileId);
          emit(
            FilesSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetAllFiles) {
        emit(
          FilesLoading(),
        );
        try {
          List<FileModel> value = await FileRepositories().getAllFiles();
          emit(
            FilesListLoaded(
              filesList: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetLatestFiles) {
        emit(
          FilesLoading(),
        );
        try {
          List<FileModel> value = await FileRepositories().getAllFiles();
          emit(
            FilesListLoaded(
              filesList: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetFileReports) {
        emit(
          FilesLoading(),
        );
        try {
          List<FileReportModel> value =
              await FileRepositories().getFileReports(event.fileId);
          emit(
            FileReportsListLoaded(
              reportsList: value,
            ),
          );
        } catch (e) {
          emit(
            FilesFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
