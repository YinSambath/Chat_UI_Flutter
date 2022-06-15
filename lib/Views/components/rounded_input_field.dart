import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Views/components/text_field_container.dart';
import 'package:mcircle_project_ui/constants.dart';

// ignore: must_be_immutable
class RoundedInputField extends StatelessWidget {
  TextEditingController controller;
  final String? labelText;
  String? Function(String?)? validator;
  final String hintText;
  final Widget? icon;
  final initialValue;
  var width;
  var height;
  final ValueChanged<String>? onChanged;
  final Function(String?)? onSaved;
  RoundedInputField({
    Key? key,
    required this.hintText,
    required this.width,
    required this.height,
    this.icon,
    this.validator,
    this.initialValue,
    this.labelText,
    required this.controller,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _phone;
    return Container(
      width: 400,
      height: 60,
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          onSaved: onSaved,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            counterText: "",
            icon: icon,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            enabled: true,
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
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
