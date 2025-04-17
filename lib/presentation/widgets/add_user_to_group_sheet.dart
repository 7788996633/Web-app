import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/presentation/widgets/users_to_add_in_group_list.dart';

import '../../blocs/user_bloc/user_bloc.dart';

class AddUserToGroupSheet extends StatefulWidget {
  const AddUserToGroupSheet({super.key, required this.groupID});
  final int groupID;
  @override
  State<AddUserToGroupSheet> createState() => _AddUserToGroupSheetState();
}

class _AddUserToGroupSheetState extends State<AddUserToGroupSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Add users to your group",
              ),
              BlocProvider(
                create: (context) => UserBloc(),
                child:  UsersToAddInGroupList(groupID: widget.groupID,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
