import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  final press;
  const Contacts({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: press,
          child: Text(
            "Contacts",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
