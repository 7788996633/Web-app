import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/user_bloc/user_bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/widgets/user_item.dart';

class GroupMembersList extends StatefulWidget {
  const GroupMembersList({super.key, required this.groupId});
  final int groupId;
  @override
  State<GroupMembersList> createState() => _GroupMembersListState();
}

class _GroupMembersListState extends State<GroupMembersList> {
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
        crossAxisCount: 2,
        childAspectRatio: 2,
      ),
      itemCount: groupMembersList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => UserItem(
        userModel: groupMembersList[index],
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
