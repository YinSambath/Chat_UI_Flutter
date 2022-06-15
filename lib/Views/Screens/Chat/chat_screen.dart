import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Models/user_model.dart';
import 'package:mcircle_project_ui/Views/Screens/Chat/components/body.dart';

class Chat extends StatelessWidget {
  final UserModel userData;

  const Chat({Key? key, required this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(userData: userData,),
    );
  }
}
