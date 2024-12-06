import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/data/models/user_model.dart';
import 'package:webapp/presentation/widgets/create_group_with_user_sheet.dart';
import 'package:webapp/presentation/widgets/custom_scaffold.dart';
import 'package:webapp/presentation/widgets/shared_groups_list.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: userModel.name,
      body: Column(
        children: [
          const Text(
            'Shared Groups',
          ),
          BlocProvider(
            create: (context) => GroupBloc(),
            child: SharedGroupsList(
              userId: userModel.id,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (kIsWeb) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(20),
                      content: CreateGroupWithUserSheet(
                        userId: userModel.id,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return CreateGroupWithUserSheet(
                      userId: userModel.id,
                    );
                  },
                );
              }
            },
            child: Text(
              'Create Group With ${userModel.name}',
            ),
          ),
        ],
      ),
    );
  }
}
