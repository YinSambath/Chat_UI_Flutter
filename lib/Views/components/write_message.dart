import 'package:flutter/material.dart';
// import 'package:mcircle_project_ui/Views/components/text_field_container.dart';
import 'package:mcircle_project_ui/constants.dart';

class WriteMessage extends StatelessWidget {
  TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  WriteMessage({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _phone;
    return Container(
      width: 530,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0.5),
      alignment: Alignment.center,
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }
}
