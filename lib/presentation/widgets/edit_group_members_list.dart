import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/user_bloc/user_bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/widgets/user_item.dart';

import '../../blocs/group_bloc/group_bloc.dart';

class EditGroupMembersList extends StatefulWidget {
  const EditGroupMembersList({super.key, required this.groupId});
  final int groupId;
  @override
  State<EditGroupMembersList> createState() => _GroupMembersListState();
}

class _GroupMembersListState extends State<EditGroupMembersList> {
  List<UserModel> groupMembersList = [];

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(
      GetUsersListByGroupId(
        groupId: widget.groupId,
      ),
    );
    super.initState();
  }

  Widget buildgroupMembersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
      ),
      itemCount: groupMembersList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => Column(
        children: [
          UserItem(
            userModel: groupMembersList[index],
          ),
          BlocConsumer<GroupBloc, GroupState>(
            listener: (context, state) {
              if (state is GroupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.successmsg,
                        style: const TextStyle(fontSize: 16)),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is GroupFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errmsg,
                        style: const TextStyle(fontSize: 16)),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GroupBloc>(context).add(
                    DeleteUserFromGroup(
                      groupId: widget.groupId,
                      userId: groupMembersList[index].id,
                    ),
                  );
                },
                child: const Text(
                  "Delete",
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UsersListLoaded) {
          groupMembersList = state.usersList;
          return buildgroupMembersList();
        } else if (state is UserFail) {
          return Column(
            children: [
              const Text(
                "There is an error:",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.errmsg,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
