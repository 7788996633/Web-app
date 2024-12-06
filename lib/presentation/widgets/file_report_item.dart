import 'package:flutter/material.dart';
import 'package:webapp/data/models/file_report_model.dart';

class FileReportItem extends StatelessWidget {
  const FileReportItem({super.key, required this.fileReportModel});
  final FileReportModel fileReportModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          fileReportModel.userName,
        ),
        subtitle: Text(fileReportModel.action),
        trailing: Text(
          '${fileReportModel.dateTime.minute}',
        ),
      ),
    );
  }
}
