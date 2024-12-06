import 'package:flutter/material.dart';

import 'custom_list_tile.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          onTap: onTap,
          title: title,
          icon: icon,
        ),
      ],
    );
  }
}
