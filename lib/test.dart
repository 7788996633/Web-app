import 'package:flutter/material.dart';
import 'package:webapp/data/services/group_services.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // Uint8List? fileData; // تعريف المتغير لتخزين محتوى الملف
  // String? fileName; // لتخزين اسم الملف

  // Future<void> pickFile() async {
  //   final result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     setState(() {
  //       fileData = result.files.first.bytes; // تخزين البيانات
  //       fileName = result.files.first.name; // تخزين الاسم
  //     });
  //     print('File picked: $fileName');
  //   } else {
  //     print('No file selected.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IconButton(
        onPressed: () {
          GroupServices().createGroup("name", "desc");
        },
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
