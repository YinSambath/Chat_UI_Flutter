import 'package:mcircle_project_ui/chat_app.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late bool result;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _comfirmedPassword = TextEditingController();
  late UserModel _UserModel;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final PrefService _prefs = PrefService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Container(
          width: 500,
          height: 800,
          child: Card(
            color: Color.fromRGBO(248, 248, 248, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.35),
                width: 1,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  SizedBox(height: size.height * 0.08),
                  RoundedInputField(
                    width: 195,
                    height: 50,
                    hintText: "Firstname",
                    controller: _firstname,
                    onChanged: (value) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  RoundedInputField(
                    width: 195,
                    height: 50,
                    hintText: "Lastname",
                    controller: _lastname,
                    onChanged: (value) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  RoundedInputField(
                    width: 400,
                    height: 50,
                    hintText: "Username",
                    controller: _username,
                    onChanged: (value) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  RoundedInputNumberField(
                    width: 400,
                    height: 50,
                    hintText: "Mobile phone",
                    controller: _phone,
                    onChanged: (value) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  RoundedInputField(
                    width: 400,
                    height: 50,
                    hintText: "Email (Optional)",
                    controller: _email,
                    onChanged: (value) => {},
                  ),
                  SizedBox(height: 8),
                  RoundedPasswordField(
                    width: 400,
                    height: 50,
                    text: "Password",
                    controller: _password,
                    onChanged: (value) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  RoundedComfirmedPasswordField(
                    width: 400,
                    height: 50,
                    controller: _comfirmedPassword,
                    onChanged: (value) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Comfirm Password field required';
                      }
                      return null;
                    },
                  ),
                  RoundedButton(
                    text: "SIGNUP",
                    onPressed: () async {
                      final bool _isValid = _formKey.currentState!.validate();
                      if (_isValid) {
                        String username = _username.text;
                        String firstname = _firstname.text;
                        String lastname = _lastname.text;
                        String phone = _phone.text;
                        String email = _email.text;
                        String password = _password.text;
                        String comfirmedPassword = _comfirmedPassword.text;

                        var response = await signup(
                            firstname,
                            lastname,
                            username,
                            phone,
                            email,
                            password,
                            comfirmedPassword);
                        print(response);
                        if (response == 200) {
                          Get.snackbar("Register", "successful");
                          var _user = await _prefs.readState("user");
                          Map<String, dynamic> _data = jsonDecode(_user);
                          UserModel _userData = UserModel.fromJson(_data);
                          Get.to(HomePage(userData: _userData));
                        } else {
                          Get.snackbar("Error", "Please try again!");
                        }
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.001),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Get.to(LoginScreen());
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

// ignore: missing_return
