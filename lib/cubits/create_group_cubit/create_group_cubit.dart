import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/services/group_services.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupInitial());
  void createGroup(String name, String desc) {
    emit(
      CreateGroupLoading(),
    );
    try {
      GroupServices().createGroup(name, desc).then(
            (value) => emit(
              CreateGroupSuccess(
                successmsg: value,
              ),
            ),
          );
    } on Exception catch (e) {
      emit(
        CreateGroupFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
