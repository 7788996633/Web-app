import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/presentation/widgets/custom_text_feild.dart';

import '../../blocs/files_bloc/files_bloc.dart';

class UploadFileSheet extends StatefulWidget {
  const UploadFileSheet({super.key});

  @override
  State<UploadFileSheet> createState() => _UploadFileSheetState();
}

class _UploadFileSheetState extends State<UploadFileSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? filePath;
  String? fileName;

  FocusNode nameFocusNode = FocusNode();

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          fileName = result.files.single.name; // اسم الملف
          filePath =
              result.files.single.path; // المسار (قد يكون null على الويب)
        });

        if (filePath == null) {
          print(
              "Web platform: Cannot get file path, only file name is available.");
        } else {
          print("File selected: $fileName, Path: $filePath");
        }
      } else {
        setState(() {
          filePath = null;
          fileName = null;
        });
        print("No file selected.");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilesBloc(),
      child: BlocConsumer<FilesBloc, FilesState>(
        listener: (context, state) {
          if (state is FilesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.successmsg,
                  style: const TextStyle(fontSize: 16),
                ),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is FilesFail) {
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
              color: Colors.red,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFeild(
                      text: "File Name",
                      iconData: Icons.title,
                      controller: _nameController,
                      validator: (p0) {
                        return null;
                      },
                    ),
                    Text(fileName != null
                        ? 'Selected File: $fileName'
                        : 'No file selected.'),
                    ElevatedButton(
                      onPressed: pickFile,
                      child: const Text("Pick File"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (fileName != null && filePath != null) {
                          BlocProvider.of<FilesBloc>(context).add(
                            UpLoadFile(
                              fileName: fileName!,
                              filePath: filePath!,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a file first!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text("Upload File"),
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
