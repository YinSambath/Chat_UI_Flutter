import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0.5),
      width: size.width * 0.2,
      height: size.height * 0.06,
      // decoration: BoxDecoration(
      //   color: kPrimaryLightColor,
      //   borderRadius: BorderRadius.circular(29),
      // ),
      child: child,
    );
  }
}
