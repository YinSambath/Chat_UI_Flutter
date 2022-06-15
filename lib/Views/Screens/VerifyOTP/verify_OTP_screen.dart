import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Views/Screens/VerifyOTP/components/body.dart';

class VerifyOTP extends StatelessWidget {
  final TextEditingController _phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
