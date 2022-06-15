// import 'package:mcircle_project_ui/chat_app.dart';

import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/chat_app.dart';
// import 'package:mcircle_project_ui/Views/Screens/side_bar.dart';

class HomePage extends StatelessWidget {
  final UserModel userData;
  const HomePage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideBar(userData: userData,),
    );
  }
}
