import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/change_color_mode_bloc/change_color_mode_bloc.dart';
import 'package:webapp/const.dart';
import 'package:webapp/presentation/screens/all_files_screen.dart';
import 'package:webapp/presentation/screens/all_groups_screen.dart';
import 'package:webapp/presentation/screens/all_users_screen.dart';
import 'package:webapp/presentation/screens/home_screen.dart';
import 'package:webapp/presentation/widgets/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<Home> {
  int _selectedIndex = 0;
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier<bool>(false);
  final List<Widget> _pages = [
    const HomeScreen(),
    const AllFilesScreen(),
    const AllGroupsScreen(),
    const AllUsersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeColorModeBloc, ChangeColorModeState>(
      builder: (context, state) {
        if (state is LightMode) {
          myColors = state.colorsMap;
        } else if (state is DarkMode) {
          myColors = state.colorsMap;
        }
        return Scaffold(
          backgroundColor: myColors['backGround'],
          body: Row(
            children: [
              CustomDrawer(
                onItemTapped: _onItemTapped,
                isExpandedNotifier: _isExpandedNotifier,
                selectedIndex: _selectedIndex,
              ),
              Expanded(
                child: Center(
                  child: _pages[_selectedIndex],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
