import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/widgets/file_item.dart';

class GroupFilesList extends StatefulWidget {
  const GroupFilesList({super.key, required this.groupId});
  final int groupId;
  @override
  State<GroupFilesList> createState() => _GroupFilesListState();
}

class _GroupFilesListState extends State<GroupFilesList> {
  List<FileModel> groupFilesList = [];

  @override
  void initState() {
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
        childAspectRatio: 4,
      ),
      itemCount: groupFilesList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => FileItem(
        fileModel: groupFilesList[index],
        file: GetGroupFiles(groupID: widget.groupId),
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
