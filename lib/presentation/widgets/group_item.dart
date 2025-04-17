import 'package:flutter/material.dart';
import 'package:webapp/const.dart';
import 'package:webapp/data/models/group_model.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: myColors['CardColor'],
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => UserBloc(),
                    child: GroupInfoScreen(groupModel: groupModel),
                  ),
                ),
              );
            },
            title: const Icon(
              Icons.groups,
              color: Colors.white,
              size: 100,
            ),
            subtitle: Text(
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              groupModel.groupName,
            ),
          ),
        ],
      ),
    );
  }
}
