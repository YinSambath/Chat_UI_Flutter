import 'package:mcircle_project_ui/chat_app.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _newComfirmedPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Drawer(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: DrawerHeader(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: kPrimaryColor,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final bool _isValid =
                                      _formKey.currentState!.validate();
                                  if (_isValid) {
                                    String currentPassword =
                                        _currentPassword.text;
                                    String newPassword = _newPassword.text;
                                    String newComfirmedPassword =
                                        _newComfirmedPassword.text;
                                    var response = await changePassword(
                                      currentPassword,
                                      newPassword,
                                      newComfirmedPassword,
                                    );
                                    if (response == 200) {
                                      Get.snackbar("Done",
                                          "Your password has been changed.");
                                      Navigator.of(context).pop();
                                      _currentPassword.clear();
                                      _newPassword.clear();
                                      _newComfirmedPassword.clear();
                                    } else {
                                      Get.snackbar("error", "....!");
                                    }
                                  }
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  RoundedPasswordField(
                    width: 280,
                    height: 50,
                    text: "Current Password",
                    controller: _currentPassword,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Current password field requires';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  RoundedPasswordField(
                    width: 280,
                    height: 50,
                    text: "password",
                    controller: _newPassword,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password field requires';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  RoundedPasswordField(
                    width: 280,
                    height: 50,
                    text: 'comfirm password',
                    controller: _newComfirmedPassword,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Comfirm password field requires';
                      } else if (_newComfirmedPassword.text !=
                          _newPassword.text) {
                        return 'Comfirm password does not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
