import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/services/file_services.dart';

part 'download_file_event.dart';
part 'download_file_state.dart';

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  DownloadFileBloc() : super(DownloadFileInitial()) {
    on<DownloadFileEvent>((event, emit) async{
 if (event is DownLoadFiles) {
        emit(
          DownloadFileLoading(),
        );
        try {
          String value = await FileServices().downloadFile(event.fileID);
          print(value + 'aaaaaaaaaaaaaaaaaaaaaaaaaaa');
          emit(
            DownloadFileSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            DownloadFileFail(
              errmsg: e.toString(),
            ),
          );
        }
      }     });
  }
}
