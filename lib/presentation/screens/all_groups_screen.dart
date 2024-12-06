import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/presentation/widgets/group_list.dart';

class AllGroupsScreen extends StatelessWidget {
  const AllGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("data"),
            BlocProvider(
              create: (context) => GroupBloc(),
              child: const GroupList(),
            ),
          ],
        ),
      ),
    );
  }
}
