import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/widgets/file_item.dart';

class LatestFilesList extends StatefulWidget {
  const LatestFilesList({super.key});

  @override
  State<LatestFilesList> createState() => _FileListState();
}

class _FileListState extends State<LatestFilesList> {
  @override
  void initState() {
    BlocProvider.of<FilesBloc>(context).add(
      GetLatestFiles(),
    );
    super.initState();
  }

  List<FileModel> fileList = [];
  Widget buildFileList() {
    return ListView.builder(
      itemCount: fileList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => FileItem(
        file: GetLatestFiles(),
        fileModel: fileList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilesBloc, FilesState>(
      builder: (context, state) {
        if (state is FilesListLoaded) {
          fileList = state.filesList;
          return buildFileList();
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
