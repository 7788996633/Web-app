import 'package:flutter/material.dart';
import 'package:webapp/const.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key, required this.title, this.actions, required this.body});
  final String title;
  final List<Widget>? actions;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors['backGround'],
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: body,
    );
  }
}
