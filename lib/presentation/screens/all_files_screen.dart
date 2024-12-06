import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/presentation/widgets/file_list.dart';

class AllFilesScreen extends StatelessWidget {
  const AllFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("data"),
              BlocProvider(
                create: (context) => FilesBloc(),
                child: const FileList(),
              ),
            ],
          ),
        ),
      );
  }
}
