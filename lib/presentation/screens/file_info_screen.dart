import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/widgets/custom_scaffold.dart';
import 'package:webapp/presentation/widgets/file_reports_list.dart';

class FileInfoScreen extends StatelessWidget {
  const FileInfoScreen({super.key, required this.fileModel});
  final FileModel fileModel;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: fileModel.fileName,
      body: Column(
        children: [
          Text(
            fileModel.status == 0 ? 'Available' : 'Busy',
            style: TextStyle(
              color:
                  fileModel.status == 0 ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
          const Text('File history'),
          BlocProvider(
            create: (context) => FilesBloc(),
            child: FileReportsList(fileId: fileModel.id),
          ),
        ],
      ),
    );
  }
}
