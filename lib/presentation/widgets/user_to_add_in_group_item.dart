import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/screens/user_info_screen.dart';

import '../../const.dart';

class UserToAddInGroupItem extends StatelessWidget {
  const UserToAddInGroupItem(
      {super.key, required this.userModel, required this.groupID});
  final UserModel userModel;
  final int groupID;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupBloc(),
      child: Card(
        color: myColors['CardColor'],
        child: ListTile(
          trailing: BlocConsumer<GroupBloc, GroupState>(
            listener: (context, state) {
              if (state is GroupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.successmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is GroupFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GroupBloc>(context).add(
                    AddUserToGroup(
                      groupId: groupID,
                      userId: userModel.id,
                    ),
                  );
                },
                child: const Text('Add'),
              );
            },
          ),
          leading: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onTap: () {
            if (myId == userModel.id) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'This user is You',
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Color.fromARGB(255, 122, 39, 190),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserInfoScreen(
                    userModel: userModel,
                  ),
                ),
              );
            }
          },
          title: Text(
            userModel.name,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
