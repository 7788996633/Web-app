import 'package:flutter/material.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/screens/user_info_screen.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserInfoScreen(
                userModel: userModel,
              ),
            ),
          );
        },
        title: Text(
          userModel.name,
        ),
      ),
    );
  }
}
