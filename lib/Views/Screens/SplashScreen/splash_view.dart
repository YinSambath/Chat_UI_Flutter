import 'package:mcircle_project_ui/chat_app.dart';

class SplashView extends StatefulWidget {
  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  final PrefService _prefs = PrefService();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () async {
      var _user = await _prefs.readState("user");
      if (_user != null) {
        Map<String, dynamic> _data = jsonDecode(_user);
        UserModel _userData = UserModel.fromJson(_data);
        Get.to(HomePage(userData: _userData,));
      } else {
              Get.to(WelcomeScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo makfood & mcircle.png',
                  ),
                  const SizedBox(width: 20),
                  Text("Welcome MCIRCLE chat application"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                '© 2022 All Right reserved to Mak Circle Col., Ltd',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
