// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:webapp/blocs/files_bloc/files_bloc.dart';
// import 'package:webapp/blocs/user_bloc/user_bloc.dart';
// import 'package:webapp/data/models/group_model.dart';
// import 'package:webapp/presentation/screens/edit_group_screen.dart';
// import 'package:webapp/presentation/widgets/add_user_to_group_sheet.dart';
// import 'package:webapp/presentation/widgets/custom_scaffold.dart';
// import 'package:webapp/presentation/widgets/group_files_list.dart';
// import 'package:webapp/presentation/widgets/group_members_list.dart';

// import '../widgets/upload_file_sheet.dart';

// class GroupInfoScreen extends StatefulWidget {
//   const GroupInfoScreen({super.key, required this.groupModel});
//   final GroupModel groupModel;

//   @override
//   State<GroupInfoScreen> createState() => _GroupInfoScreenState();
// }

// class _GroupInfoScreenState extends State<GroupInfoScreen> {
//   @override
//   void initState() {
//     // استدعاء الحدث للحصول على دور المستخدم
//     BlocProvider.of<UserBloc>(context).add(
//       GetUserRole(
//         groupId: widget.groupModel.id,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       actions: [
//         BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is UserRoleIsAdmin) {
//               return IconButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => EditGroupScreen(
//                         groupModel: widget.groupModel,
//                       ),
//                     ),
//                   );
//                 },
//                 icon: const Icon(
//                   Icons.edit,
//                 ),
//               );
//             }
//             return Container(); // إرجاع عنصر فارغ إذا لم يكن مالكًا
//           },
//         ),
//         IconButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   contentPadding: const EdgeInsets.all(20),
//                   content: BlocProvider(
//                     create: (context) => FilesBloc(),
//                     child: UploadFileSheet(
//                       groupID: widget.groupModel.id,
//                     ),
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('Close'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           icon: const Icon(
//             Icons.upload_file,
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             if (kIsWeb) {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     content: SizedBox(
//                       width: MediaQuery.sizeOf(context).width * 0.5,
//                       height: MediaQuery.sizeOf(context).height * 0.5,
//                       child: AddUserToGroupSheet(
//                         groupID: widget.groupModel.id,
//                       ),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: const Text('Close'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             } else {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 builder: (BuildContext context) {
//                   return AddUserToGroupSheet(
//                     groupID: widget.groupModel.id,
//                   );
//                 },
//               );
//             }
//           },
//           icon: const Icon(
//             Icons.group_add,
//           ),
//         ),
//       ],
//       title: widget.groupModel.groupName,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // عرض حالة المستخدم كمالك أو عضو
//             BlocBuilder<UserBloc, UserState>(
//               builder: (context, state) {
//                 if (state is UserRoleIsAdmin) {
//                   return const Text(
//                     "You are the owner",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 } else if (state is UserRoleIsMember) {
//                   return const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "You are a member",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 } else if (state is UserFail) {
//                   return Text(
//                     state.errmsg,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 } else {
//                   return const CircularProgressIndicator();
//                 }
//               },
//             ),
//             const Text(
//               'Members',
//             ),
//             BlocProvider(
//               create: (context) => UserBloc(),
//               child: GroupMembersList(
//                 groupId: widget.groupModel.id,
//               ),
//             ),
//             const Text(
//               'Files',
//             ),
//             BlocProvider(
//               create: (context) => FilesBloc(),
//               child: GroupFilesList(
//                 groupId: widget.groupModel.id,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
