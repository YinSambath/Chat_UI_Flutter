import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcircle_project_ui/Views/components/text_field_container.dart';
import 'package:mcircle_project_ui/constants.dart';

class RoundedInputNumberField extends StatelessWidget {
  TextEditingController controller;
  final String? labelText;
  final String hintText;
  var width;
  var height;
  String? Function(String?)? validator;
  final Widget? icon;
  final ValueChanged<String> onChanged;
  RoundedInputNumberField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.width,
    required this.height,
    this.validator,
    this.icon,
    this.labelText,
    required this.onChanged,
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
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            counterText: '',
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            prefixIcon: icon,
            hintText: hintText,
            labelText: labelText,
            enabled: true,
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
