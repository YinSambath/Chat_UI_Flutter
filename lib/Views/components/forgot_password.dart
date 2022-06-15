import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/constants.dart';

class ForgotPassword extends StatelessWidget {
  final press;
  const ForgotPassword({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: press,
          child: Text(
            "forgot password",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
