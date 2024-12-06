import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/const.dart';
import 'package:webapp/data/models/file_model.dart';
import 'package:webapp/presentation/screens/file_info_screen.dart';

class FileItem extends StatefulWidget {
  const FileItem({super.key, required this.fileModel, required this.file});
  final FileModel fileModel;
  final FilesEvent file;
  @override
  State<FileItem> createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
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
                    onPressed: () {
                      if (widget.fileModel.status == 0) {
                        BlocProvider.of<FilesBloc>(context).add(
                          FileCheckIn(
                            fileId: widget.fileModel.id,
                          ),
                        );
                        BlocProvider.of<FilesBloc>(context).add(widget.file);
                      } else {
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
                    icon: Icon(
                      widget.fileModel.status == 0
                          ? Icons.check_box_outline_blank
                          : Icons.indeterminate_check_box,
                    ),
                  ),
                  trailing: BlocConsumer<FilesBloc, FilesState>(
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
                  subtitle: Text(
                    widget.fileModel.status == 0 ? 'Available' : 'Busy',
                    style: TextStyle(
                      color: widget.fileModel.status == 0
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
