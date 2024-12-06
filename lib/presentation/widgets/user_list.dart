import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/user_bloc/user_bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/widgets/user_item.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(
      GetAllUsers(),
    );
    super.initState();
  }

  List<UserModel> userModel = [];
  Widget buildUserModel() {
    return ListView.builder(
      itemCount: userModel.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => UserItem(
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
