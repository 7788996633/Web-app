import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/presentation/widgets/custom_text_feild.dart';

import '../../const.dart';

class CreateGroupWithUserSheet extends StatefulWidget {
  const CreateGroupWithUserSheet({super.key, required this.userId});
  final int userId;
  @override
  State<CreateGroupWithUserSheet> createState() => _CreateGroupSheetState();
}

class _CreateGroupSheetState extends State<CreateGroupWithUserSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupBloc(),
      child: BlocConsumer<GroupBloc, GroupState>(
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
          return Scaffold(
            body: Container(
              color: myColors['background'],
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFeild(
                      text: "Group Name",
                      iconData: Icons.title,
                      controller: _nameController,
                      validator: (p0) {
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<GroupBloc>(context).add(
                          CreateGroupWithUser(
                            groupName: _nameController.text,
                            userId: widget.userId,
                          ),
                        );
                      },
                      child: const Text("Create Group"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
