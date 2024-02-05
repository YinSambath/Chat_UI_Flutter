import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class TermCondition extends StatelessWidget {
  TermCondition({Key? key}) : super(key: key);
  final backgroundColor = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Container(
          width: 820,
          child: Scrollbar(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: 800,
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Term & Conditions",
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 800,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1. Acceptance of Terms: By accessing and using this chat application ('the Application'), you agree to comply with and be bound by the following terms and conditions. If you do not agree with these terms, please refrain from using the Application.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "User Accounts: a. Users must provide accurate and complete information during the registration process. b. Users are responsible for maintaining the confidentiality of their account credentials. c. Users must promptly notify the Application's administrators of any unauthorized use or security breaches.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "User Conduct: a. Users agree to use the Application for lawful purposes only. b. Users shall not engage in any behavior that violates the rights of others or disrupts the Application's functionality.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Content: a. Users are solely responsible for the content they share through the Application. b. The Application reserves the right to monitor, review, and remove content that violates these terms.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Privacy and Data Security: a. The Application collects and processes user data in accordance with the privacy policy. b. Users are encouraged to review the privacy policy to understand how their data is handled.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
