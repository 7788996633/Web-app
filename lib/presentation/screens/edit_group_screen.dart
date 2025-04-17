import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/presentation/widgets/custom_scaffold.dart';

import '../../blocs/files_bloc/files_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../data/models/group_model.dart';
import '../widgets/edit_group_files_list.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({super.key, required this.groupModel});
  final GroupModel groupModel;
  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Edit Group',
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Members',
            ),
            BlocProvider(
              create: (context) => UserBloc(),
              child: EditGroupFilesList(
                groupId: widget.groupModel.id,
              ),
            ),
            const Text(
              'Files',
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => FilesBloc(),
                ),
                BlocProvider(
                  create: (context) => GroupBloc(),
                ),
              ],
              child: EditGroupFilesList(
                groupId: widget.groupModel.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
