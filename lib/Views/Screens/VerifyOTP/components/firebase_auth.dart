import 'dart:html';

import 'package:mcircle_project_ui/chat_app.dart';

class FirebaseAuthentication {
  String phone = "";
  sendOTP(String phone) async {
    this.phone = phone;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      '+855 $phone',
      // RecaptchaVerifier(
      //   container: 'recaptcha',
      //   size: RecaptchaVerifierSize.compact,
      //   theme: RecaptchaVerifierTheme.dark,
      //   onSuccess: () => print('reCAPTCHA Completed!'),
      //   onError: (FirebaseAuthException error) => print(error),
      //   onExpired: () => print('reCAPTCHA Expired!'),
      // ),
    );
    final el = window.document.getElementById('__ff-recaptcha-container');
    if (el != null) {
      el.style.visibility = 'hidden';
      el.remove();
    }
    print("OTP Sent to +855 $phone");
    return confirmationResult;
  }

  authenticateMe(ConfirmationResult confirmationResult, String otp) async {
    UserCredential userCredential = await confirmationResult.confirm(otp);
    if (userCredential != "" || userCredential != null) {
      Get.snackbar("Success", "OTP comfirmed");
      Get.to(ResetPassword());
    } else {
      Get.snackbar("Fail", "The SMS code has expired");
    }
  }
}
