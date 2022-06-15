import 'package:mcircle_project_ui/chat_app.dart';

const String SplashRoute = "/splash";
const String HomeRoute = "/home";
const String LoginRoute = "/login";
const String RegisterRoute = "/register";
const String WelcomeRoute = "/welcome";
const String VerifyOTPRoute = "/verifyOTP";
const String ChangePasswordRoutes = "/ChangePassword";

final routes = {
  SplashRoute: (context) => SplashView(),
  // HomeRoute: (context) => HomePage(),
  LoginRoute: (context) => LoginScreen(),
  RegisterRoute: (context) => RegisterScreen(),
  WelcomeRoute: (context) => WelcomeScreen(),
  VerifyOTPRoute: (context) => VerifyOTP(),
  ChangePasswordRoutes: (context) => ResetPassword(),
};
