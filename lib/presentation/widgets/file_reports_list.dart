import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/data/models/file_report_model.dart';
import 'package:webapp/presentation/widgets/file_report_item.dart';

class FileReportsList extends StatefulWidget {
  const FileReportsList({super.key, required this.fileId});
  final int fileId;
  @override
  State<FileReportsList> createState() => _GroupListState();
}

class _GroupListState extends State<FileReportsList> {
  @override
  void initState() {
    BlocProvider.of<FilesBloc>(context).add(
      GetFileReports(fileId: widget.fileId),
    );
    super.initState();
  }

  List<FileReportModel> fileReportsList = [];
  Widget buildGroupList() {
    return ListView.builder(
      itemCount: fileReportsList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => FileReportItem(
        fileReportModel: fileReportsList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilesBloc, FilesState>(
      builder: (context, state) {
        if (state is FileReportsListLoaded) {
          fileReportsList = state.reportsList;
          return buildGroupList();
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
