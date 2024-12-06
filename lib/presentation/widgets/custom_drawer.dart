import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/change_color_mode_bloc/change_color_mode_bloc.dart';
import 'package:webapp/const.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(
      {super.key,
      required this.onItemTapped,
      required this.isExpandedNotifier,
      required this.selectedIndex});
  final Function(int) onItemTapped;
  final ValueNotifier<bool> isExpandedNotifier;
  final int selectedIndex;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void _toggleDrawer() {
    widget.isExpandedNotifier.value = !widget.isExpandedNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isExpandedNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return AnimatedContainer(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 176, 138, 190),
                Color.fromARGB(255, 115, 55, 218),
              ],
            ),
          ),
          duration: const Duration(milliseconds: 300),
          width: value
              ? MediaQuery.sizeOf(context).width * 0.2
              : MediaQuery.sizeOf(context).width * 0.1,
          child: Drawer(
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 227, 148, 241),
                    Color.fromARGB(255, 167, 97, 180),
                  ],
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _toggleDrawer,
                    child: DrawerHeader(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu,
                              color: myColors['IconColor'],
                            ),
                            if (value)
                              BlocConsumer<ChangeColorModeBloc,
                                  ChangeColorModeState>(
                                listener: (context, state) {
                                  if (state is LightMode) {
                                    print('lightmode');
                                    setState(() {
                                      myColors = state.colorsMap;
                                    });
                                    print(myColors);
                                  }
                                  if (state is DarkMode) {
                                    print('Darkmode');

                                    setState(() {
                                      myColors = state.colorsMap;
                                    });
                                    print(myColors);
                                  }
                                },
                                builder: (context, state) {
                                  return MaterialButton(
                                    onPressed: () {
                                      if (state is DarkMode) {
                                        BlocProvider.of<ChangeColorModeBloc>(
                                                context)
                                            .add(
                                          ChangeColorsModetolight(),
                                        );
                                      } else {
                                        BlocProvider.of<ChangeColorModeBloc>(
                                                context)
                                            .add(
                                          ChangeColorsModetoDark(),
                                        );
                                      }
                                    },
                                    child: Icon(
                                      state is DarkMode
                                          ? Icons.dark_mode
                                          : Icons.light_mode,
                                      color: myColors['IconColor'],
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildListTile(0, 'Home', Icons.home, value, null),
                  _buildListTile(1, 'All Files', Icons.file_copy, value, null),
                  _buildListTile(2, 'All Groups', Icons.groups, value, null),
                  _buildListTile(3, 'All Users', Icons.person, value, null),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ListTile _buildListTile(int index, String title, IconData icon,
      bool isExpanded, void Function()? onTap) {
    final isSelected = widget.selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? const Color.fromARGB(255, 255, 255, 255)
            : Colors.purple, // Icon color based on selection
      ),
      title: isExpanded
          ? Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Colors.purple, // Text color based on selection
              ),
            )
          : null,
      selected: isSelected,
      // selectedTileColor: const Color.fromARGB(255, 81, 171, 244),
      shape: isSelected
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Rounded corners for selected item
            )
          : null,
      onTap: () => onTap ?? widget.onItemTapped(index),
    );
  }
}
