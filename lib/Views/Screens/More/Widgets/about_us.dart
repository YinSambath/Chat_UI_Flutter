import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  final backgroundColor = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: 40,
            width: 800,
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "About Us",
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
              padding: EdgeInsets.all(20),
              child: Text(
                "We created this application in order to make people easy to communicate each other by using phone",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            width: 800,
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Contacts: ",
              style: TextStyle(
                color: black,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            width: 800,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.web),
                          label: Text('Webside: '),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.transparent;
                                }
                                return Colors.transparent;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 148),
                        InkWell(
                          child: Text(
                            "www.google.com",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                          onTap: () => launch("https://www.google.com"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.facebook),
                          label: Text(
                            'Facebook Page: ',
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.transparent;
                                }
                                return Colors.transparent;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 105),
                        InkWell(
                          child: Text(
                            "Facebook Page",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                          onTap: () => launch("https://www.facebook.com/"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.mail_outline_sharp),
                        label: Text('Gmail: '),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.transparent;
                              }
                              return Colors.transparent;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 165),
                      InkWell(
                        child: Text(
                          "wuba.developer@gmail.com",
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        ),
                        onTap: () => launch("wuba.developer@gmail.com"),
                      ),
                    ],
                  )),
                  SizedBox(width: 40),
                  Container(
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.phone),
                          label: Text('Phone Number: '),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.transparent;
                                }
                                return Colors.transparent;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 108),
                        InkWell(
                          child: Text(
                            "+855 10827251",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                          onTap: () {
                            Get.snackbar("Sorry", "We are not implement yet!");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
