import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/change_color_mode_bloc/change_color_mode_bloc.dart';
import 'package:webapp/const.dart';
import 'package:webapp/cubits/login_cubit/login_cubit.dart';
import 'package:webapp/presentation/screens/auth_screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeColorModeBloc(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<ChangeColorModeBloc, ChangeColorModeState>(
          builder: (context, state) {
            if (state is LightMode) {
              myColors = state.colorsMap;
            } else if (state is DarkMode) {
              myColors = state.colorsMap;
            }
            return BlocProvider(
              create: (context) => LoginCubit(),
              child: const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
