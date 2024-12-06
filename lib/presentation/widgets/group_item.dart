import 'package:flutter/material.dart';
import 'package:webapp/const.dart';
import 'package:webapp/data/models/group_model.dart';
import 'package:webapp/presentation/screens/group_info_screen.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: myColors['CardColor'],
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GroupInfoScreen(groupModel: groupModel),
            ),
          );
        },
        title: Text(
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
          groupModel.groupName,
        ),
      ),
    );
  }
}
