import 'package:mcircle_project_ui/chat_app.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final PrefService _prefs = PrefService();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  // late UserModel _UserModel;
  bool canShow = false;
  var temp;
  @override
  void dispose() {
    _phoneNumber.dispose();
    otp.dispose();
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 450,
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
                children: [
                  Text("VerifyOTP"),
                  buildTextField(
                    "Phone Number",
                    _phoneNumber,
                    Icons.phone,
                    context,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone field requires';
                      }
                      return null;
                    },
                  ),
                  canShow
                      ? Column(
                          children: [
                            buildTextField(
                              "OTP",
                              otp,
                              Icons.timer,
                              context,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'OTP field requires';
                                }
                                return null;
                              },
                            ),
                            Text("You haven't received the code?"),
                            SizedBox(height: 5)
                          ],
                        )
                      : const SizedBox(),
                  !canShow
                      ? buildSendOTPBtn("Send OTP")
                      : buildSubmitBtn("Submit"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSendOTPBtn(String text) => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        ),
        onPressed: () async {
          final bool _isValid = _formKey.currentState!.validate();
          if (_isValid) {
            String phone = _phoneNumber.text;
            var response = await checkPhone(phone);
            if (response != "") {
              setState(() {
                canShow = !canShow;
              });

              temp = await FirebaseAuthentication().sendOTP(phone);
            }
          }
        },
        child: Text(text),
      );

  Widget buildSubmitBtn(String text) => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        ),
        onPressed: () async {
          final bool _isValid = _formKey.currentState!.validate();
          if (_isValid) {
            await FirebaseAuthentication().authenticateMe(temp, otp.text);
          }
        },
        child: Text(text),
      );
}
