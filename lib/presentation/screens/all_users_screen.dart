import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/user_bloc/user_bloc.dart';
import 'package:webapp/presentation/widgets/user_list.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("data"),
            BlocProvider(
              create: (context) => UserBloc(),
              child: const UserList(),
            ),
          ],
        ),
      ),
    );
  }
}
