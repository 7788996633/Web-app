import 'package:flutter/material.dart';
import 'package:webapp/data/models/file_report_model.dart';
import 'package:intl/intl.dart'; // Import to format date

class FileReportItem extends StatelessWidget {
  const FileReportItem({super.key, required this.fileReportModel});
  final FileReportModel fileReportModel;
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Card(
      child: ListTile(
        title: Text(
          fileReportModel.userName,
        ),
        subtitle: Text(fileReportModel.action),
        trailing: Text(dateFormat.format(fileReportModel.dateTime)),
      ),
    );
  }
}
