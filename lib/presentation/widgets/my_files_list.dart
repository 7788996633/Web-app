import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/widgets/my_files_item.dart';

class MyFilesList extends StatefulWidget {
  const MyFilesList({super.key});

  @override
  State<MyFilesList> createState() => _MyFilesListState();
}

class _MyFilesListState extends State<MyFilesList> {
  @override
  void initState() {
    BlocProvider.of<FilesBloc>(context).add(
      GetMyFiles(),
    );
    super.initState();
  }

  List<FileModel> myFilesList = [];
  Widget buildMyFilesList() {
    return ListView.builder(
      itemCount: myFilesList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => MyFilesItem(
        file: GetAllFiles(),
        fileModel: myFilesList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilesBloc, FilesState>(
      builder: (context, state) {
        if (state is FilesListLoaded) {
          myFilesList = state.filesList;
          return buildMyFilesList();
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
