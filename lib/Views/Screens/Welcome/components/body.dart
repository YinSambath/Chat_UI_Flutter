import 'package:mcircle_project_ui/chat_app.dart';

// class SharePrefs extends StatefulWidget {
//   SharePrefs({Key? key}) : super(key: key);

//   @override
//   State<SharePrefs> createState() => _SharePrefsState();
// }

// class _SharePrefsState extends State<SharePrefs> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final PrefService _prefs = PrefService();
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ignore: sdk_version_ui_as_code

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "MCIRCLE chat application",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // ignore: sdk_version_ui_as_code
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/mcircle Logo 512x512.png",
                    height: 300,
                    width: 300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.1),

          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            width: 500,
            height: 500,
            child: Card(
              elevation: 0,
              shadowColor: Colors.transparent,
              color: Color.fromRGBO(248, 248, 248, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RoundedInputNumberField(
                      icon: Icon(Icons.phone_outlined, color: kPrimaryColor),
                      width: 400,
                      height: 50,
                      controller: _phone,
                      hintText: "Mobile phone",
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone field requires';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    RoundedPasswordField(
                      text: 'Password',
                      width: 400,
                      height: 50,
                      controller: _password,
                      onChanged: (value) {
                        setState(() {
                          value.isNotEmpty;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password field requires';
                        }
                        return null;
                      },
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      onPressed: () async {
                        final bool _isValid = _formKey.currentState!.validate();
                        if (_isValid) {
                          String phone = _phone.text;
                          String password = _password.text;

                          var response = await signin(phone, password);
                          if (response == 200) {
                            Get.snackbar("Log in successfully",
                                "Please enjoy your time.",
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                                margin: EdgeInsets.only(left: 1230),
                                maxWidth: 300,
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                                overlayColor: kPrimaryColor);
                            var _user = await _prefs.readState("user");
                            Map<String, dynamic> _data = jsonDecode(_user);
                            UserModel _userData = UserModel.fromJson(_data);
                            Get.to(HomePage(userData: _userData));
                          } else {
                            Get.snackbar("Error",
                                "Please Register a account before login!",
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                                margin: EdgeInsets.only(left: 1230),
                                maxWidth: 300,
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                                overlayColor: kPrimaryColor);
                          }
                        }
                      },
                    ),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Get.to(
                          RegisterScreen(),
                        );
                      },
                    ),
                    ForgotPassword(
                      press: () {
                        Get.to(VerifyOTP());
                      },
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 25.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
