import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/files_bloc/files_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/presentation/widgets/create_group_sheet.dart';
import 'package:webapp/presentation/widgets/latest_files_list.dart';
import 'package:webapp/presentation/widgets/upload_file_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GroupBloc(),
        ),
        BlocProvider(
          create: (context) => FilesBloc(),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: Colors.purpleAccent,
              child: Column(
                children: [
                  const Text("Create Group"),
                  IconButton(
                    onPressed: () {
                      if (kIsWeb) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(20),
                              content: const CreateGroupSheet(),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const CreateGroupSheet();
                          },
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const Text("Recent Files"),
            BlocProvider(
              create: (context) => FilesBloc(),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: const LatestFilesList(),
              ),
            ),
            // const Card(
            //   color: Colors.purpleAccent,
            //   child: Column(
            //     children: [
            //       Text("Latest Updates"),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
