import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/widgets/file_item.dart';

import '../../blocs/group_bloc/group_bloc.dart';

class EditGroupFilesList extends StatefulWidget {
  const EditGroupFilesList({super.key, required this.groupId});
  final int groupId;
  @override
  State<EditGroupFilesList> createState() => _GroupFilesListState();
}

class _GroupFilesListState extends State<EditGroupFilesList> {
  List<FileModel> groupFilesList = [];

  @override
void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<FilesBloc>(context).add(
      GetGroupFiles(
        groupID: widget.groupId,
      ),
    );
    super.initState();
  }

  Widget buildgroupFilesList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
      ),
      itemCount: groupFilesList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => Column(
        children: [
          FileItem(
            fileModel: groupFilesList[index],
            file: GetGroupFiles(groupID: widget.groupId),
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
                    DeleteFileFromGroup(
                      groupId: widget.groupId,
                      fileId: groupFilesList[index].id,
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
    return BlocBuilder<FilesBloc, FilesState>(
      builder: (context, state) {
        if (state is FilesListLoaded) {
          groupFilesList = state.filesList;
          return buildgroupFilesList();
        } else if (state is FilesFail) {
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
