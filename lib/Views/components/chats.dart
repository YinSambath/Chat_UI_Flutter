import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  final press;
  const Chats({
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
            "Chats",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
