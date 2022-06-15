import 'package:mcircle_project_ui/chat_app.dart';

class Body extends StatelessWidget {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _comfirmedPassword = TextEditingController();
  final PrefService _prefs = PrefService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.35),
                width: 1,
              ),
            ),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Reset your password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(height: 10),
                RoundedPasswordField(
                  width: 280,
                  height: 50,
                  text: "password",
                  controller: _password,
                  onChanged: (value) {},
                ),
                SizedBox(height: 10),
                RoundedPasswordField(
                  width: 280,
                  height: 50,
                  text: 'comfirm password',
                  controller: _comfirmedPassword,
                  onChanged: (value) {},
                ),
                SizedBox(height: 10),
                RoundedButton(
                  text: "Update",
                  onPressed: () async {
                    String password = _password.text;
                    String comfirmedPassword = _comfirmedPassword.text;
                    print("Hello");
                    if (password == comfirmedPassword) {
                      print("Hello 1");
                      // final _resetLink = _prefs.readState("resetLink");
                      var response =
                          await resetPassword(password, comfirmedPassword);
                      if (response == 200) {
                        Get.snackbar(
                            "Success", "Your password has been changed");
                        Timer(
                          Duration(seconds: 2),
                          (() => Get.to(LoginScreen())),
                        );
                      } else {
                        Get.snackbar("Error", "Something went wrong");
                      }
                    } else {
                      Get.snackbar("Error", "Invalid password");
                    }
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: missing_return
