import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'change_color_mode_event.dart';
part 'change_color_mode_state.dart';

class ChangeColorModeBloc
    extends Bloc<ChangeColorModeEvent, ChangeColorModeState> {
  ChangeColorModeBloc() : super(ChangeColorModeInitial()) {
    on<ChangeColorModeEvent>((event, emit) {
      if (event is ChangeColorsModetolight) {
        emit(
          LightMode(),
        );
        
      } else if (event is ChangeColorsModetoDark) {
        emit(
          DarkMode(),
        );
      }
    });
  }
}
