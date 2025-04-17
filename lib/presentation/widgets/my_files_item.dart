import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/const.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/screens/file_info_screen.dart';

class MyFilesItem extends StatefulWidget {
  const MyFilesItem({super.key, required this.fileModel, required this.file});
  final FileModel fileModel;
  final FilesEvent file;
  @override
  State<MyFilesItem> createState() => _FileItemState();
}

class _FileItemState extends State<MyFilesItem> {
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
      BlocProvider.of<FilesBloc>(context).add(
        FileCheckOut(
          fileId: widget.fileModel.id,
          fileName: fileName!,
          fileBytes: fileBytes!,
        ),
      );
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
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FileInfoScreen(
                  fileModel: widget.fileModel,
                ),
              ),
            );
          },
          child: Card(
            color: myColors['CardColor'],
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: () async {
                      if (widget.fileModel.status == 1) {
                        uploadFile();
                      } else {
                        // BlocProvider.of<FilesBloc>(context).add(
                        //   FileCheckOut(
                        //     fileId: widget.fileModel.id,
                        //   ),
                        // );
                        // BlocProvider.of<FilesBloc>(context).add(widget.file);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'This file is not available now',
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.indeterminate_check_box,
                    ),
                  ),
                  trailing: BlocConsumer<FilesBloc, FilesState>(
                    listener: (context, state) {
                      print(
                        state.toString(),
                      );
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
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<FilesBloc>(context).add(
                            DownLoadFile(fileId: widget.fileModel.id),
                          );
                        },
                        icon: const Icon(
                          Icons.download,
                        ),
                      );
                    },
                  ),
                  title: Text(
                    widget.fileModel.fileName,
                  ),
                  subtitle: const Text(
                    'Busy',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Row(
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
