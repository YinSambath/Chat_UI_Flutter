import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Views/components/text_field_container.dart';
import 'package:mcircle_project_ui/constants.dart';

// ignore: must_be_immutable
class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  TextEditingController controller;
  var text;
  var width;
  var height;
  String? Function(String?)? validator;
  RoundedPasswordField({
    Key? key,
    required this.width,
    required this.height,
    required this.onChanged,
    this.validator,
    required this.controller,
    this.text,
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
            counterText: '',
            hintText: text,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            // suffixIcon: Icon(
            //   Icons.visibility,
            //   color: kPrimaryColor,
            // ),
            enabled: true,
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
            focusedErrorBorder: OutlineInputBorder(
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
