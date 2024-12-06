import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/user_bloc/user_bloc.dart';
import 'package:webapp/data/models/group_model.dart';
import 'package:webapp/presentation/widgets/custom_scaffold.dart';
import 'package:webapp/presentation/widgets/group_members_list.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key, required this.groupModel});
  final GroupModel groupModel;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
      title: groupModel.groupName,
      body: Column(
        children: [
          const Text(
            'Members',
          ),
          BlocProvider(
            create: (context) => UserBloc(),
            child: GroupMembersList(
              groupId: groupModel.id,
            ),
          ),
        ],
      ),
    );
  }
}
