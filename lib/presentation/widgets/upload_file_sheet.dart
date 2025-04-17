// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
import '../../blocs/files_bloc/files_bloc.dart';

class UploadFileSheet extends StatefulWidget {
  const UploadFileSheet({super.key, required this.groupID});
  final int groupID;
  @override
  State<UploadFileSheet> createState() => _UploadFileSheetState();
}

class _UploadFileSheetState extends State<UploadFileSheet> {
  String? fileName;
  Uint8List? fileBytes; // سيتم تخزين البيانات الثنائية للملف هنا

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          fileName = result.files.single.name;
          fileBytes = result.files.single.bytes; // قراءة الملف كـ bytes
        });

        print("File selected: $fileName");
      } else {
        setState(() {
          fileName = null;
          fileBytes = null;
        });
        print("No file selected.");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> uploadFile() async {
    if (fileBytes == null || fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a file first!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      BlocProvider.of<FilesBloc>(context).add(UpLoadFile(fileName: fileName!, fileBytes: fileBytes!, groupID: widget.groupID,),);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilesBloc, FilesState>(
      listener: (context, state) {
        if (state is FilesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successmsg,
                  style: const TextStyle(fontSize: 16)),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is FilesFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(state.errmsg, style: const TextStyle(fontSize: 16)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(fileName != null
                    ? 'Selected File: $fileName'
                    : 'No file selected.'),
                ElevatedButton(
                  onPressed: pickFile,
                  child: const Text("Pick File"),
                ),
                ElevatedButton(
                  onPressed: uploadFile,
                  child: const Text("Upload File"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
