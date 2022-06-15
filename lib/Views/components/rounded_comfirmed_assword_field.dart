import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Views/components/text_field_container.dart';
import 'package:mcircle_project_ui/constants.dart';

class RoundedComfirmedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  var width;
  var height;
  String? Function(String?)? validator;
  RoundedComfirmedPasswordField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.width,
    required this.height,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 60,
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          obscureText: true,
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: "Comfirm Password",
            prefixIcon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            // suffixIcon: Icon(
            //   Icons.visibility,
            //   color: kPrimaryColor,
            // ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(11),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(11),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.red),
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          validator: validator,
          controller: controller,
        ),
      ),
    );
  }
}
