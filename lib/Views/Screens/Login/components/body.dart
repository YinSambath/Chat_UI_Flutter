import 'package:mcircle_project_ui/chat_app.dart';

class Body extends StatelessWidget {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late UserModel _UserModel;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final PrefService _prefs = PrefService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 500,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.35),
                width: 1,
              ),
            ),
            color: Color.fromRGBO(248, 248, 248, 1),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  SizedBox(height: size.height * 0.08),
                  RoundedInputNumberField(
                    width: 400,
                    height: 50,
                    controller: _phone,
                    hintText: "Mobile phone or email",
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
                    width: 400,
                    height: 50,
                    text: "Password",
                    controller: _password,
                    onChanged: (value) {},
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
                          Get.snackbar("Success", "Login success");
                          var _user = await _prefs.readState("user");
                          Map<String, dynamic> _data = jsonDecode(_user);
                          UserModel _userData = UserModel.fromJson(_data);
                          Get.to(HomePage(userData: _userData,));
                        }
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.001),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Get.to(RegisterScreen());
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
        ),
      ),
    );
  }

}
