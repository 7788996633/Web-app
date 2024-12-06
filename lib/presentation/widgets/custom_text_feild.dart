import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild(
      {super.key,
      required this.text,
      required this.iconData,
      required this.controller,
      required this.validator});
  final String text;
  final IconData iconData;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            25,
          ),
        ),
        color: Color.fromARGB(255, 176, 138, 190),
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            iconData,
            color: Colors.white,
          ),
          border: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
