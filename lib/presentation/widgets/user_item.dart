import 'package:flutter/material.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/screens/user_info_screen.dart';

import '../../const.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: myColors['CardColor'],
      child: ListTile(
        title: const Icon(
          Icons.person,
          color: Colors.white,
          size: 100,
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
        subtitle: Text(
          userModel.name,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
