// ignore_for_file: must_be_immutable

part of 'change_color_mode_bloc.dart';

@immutable
sealed class ChangeColorModeEvent {}

class ChangeColorsModetolight extends ChangeColorModeEvent {
   bool lightMode = true;
}
class ChangeColorsModetoDark extends ChangeColorModeEvent {
   bool lightMode = false;
}
