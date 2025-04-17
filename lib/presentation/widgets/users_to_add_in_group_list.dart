import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/user_bloc/user_bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/widgets/user_to_add_in_group_item.dart';

class UsersToAddInGroupList extends StatefulWidget {
  const UsersToAddInGroupList({super.key, required this.groupID});
  final int groupID;
  @override
  State<UsersToAddInGroupList> createState() => _UserListState();
}

class _UserListState extends State<UsersToAddInGroupList> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(
      GetUsersNotInGroup(groupID: widget.groupID),
    );
    super.initState();
  }

  List<UserModel> userModel = [];
  Widget buildUserModel() {
    return ListView.builder(
      itemCount: userModel.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => UserToAddInGroupItem(
        groupID: widget.groupID,
        userModel: userModel[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UsersListLoaded) {
          userModel = state.usersList;
          return buildUserModel();
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
