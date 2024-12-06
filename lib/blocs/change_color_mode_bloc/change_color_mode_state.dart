part of 'change_color_mode_bloc.dart';

@immutable
sealed class ChangeColorModeState {}

final class ChangeColorModeInitial extends ChangeColorModeState {}

final class LightMode extends ChangeColorModeState {
  final Map colorsMap = {
    'backGround': Colors.white,
    'TextColor': Colors.white,
    'CardColor': const Color.fromARGB(255, 227, 148, 241),
    'IconColor': Colors.white,
  };
}

final class DarkMode extends ChangeColorModeState {
  final Map colorsMap = {
    'backGround': Colors.black,
    'TextColor': Colors.white,
    'CardColor': const Color.fromARGB(255, 114, 31, 129),
    'IconColor': Colors.white,
  };
}
