import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/group_bloc/group_bloc.dart';
import 'package:webapp/data/models/group_model.dart';
import 'package:webapp/presentation/widgets/group_item.dart';

class SharedGroupsList extends StatefulWidget {
  const SharedGroupsList({super.key, required this.userId});
  final int userId;
  @override
  State<SharedGroupsList> createState() => _SharedGroupListState();
}

class _SharedGroupListState extends State<SharedGroupsList> {
  @override
  void initState() {
    BlocProvider.of<GroupBloc>(context).add(
      GetSharedGroups(userId: widget.userId),
    );
    super.initState();
  }

  List<GroupModel> groupList = [];
  Widget buildGroupList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
      ),
      itemCount: groupList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => GroupItem(
        groupModel: groupList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        print('=======================================');
        if (state is GroupListLoaded) {
          print('+++++++++++++++++++++++++++++++++++++++++');

          groupList = state.groupList;
          return buildGroupList();
        } else if (state is GroupFail) {
          print('********************************');

          return Column(
            children: [
              const Text(
                "There is an error:",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.errmsg,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
