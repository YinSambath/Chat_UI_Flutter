// ignore: import_of_legacy_library_into_null_safe
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Views/Screens/More/Widgets/about_us.dart';
import 'package:mcircle_project_ui/Views/Screens/More/Widgets/change_password.dart';
import 'package:mcircle_project_ui/Views/Screens/More/Widgets/resume.dart';
import 'package:mcircle_project_ui/Views/Screens/More/Widgets/term_conditions.dart';
import 'package:mcircle_project_ui/Views/Screens/More/Widgets/update_profile.dart';

import 'package:mcircle_project_ui/chat_app.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final backgroundColor = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;
  int? _a;
  int? _seletedItem;
  final PrefService _prefs = PrefService();
  List items = [
    Item(
      item: "Resume",
      icon: SvgPicture.asset("../../../../assets/icons/open-document.svg"),
    ),
    Item(
      item: "Notifications",
      icon: SvgPicture.asset("../../../../assets/icons/notifications.svg"),
    ),
    Item(
      item: "Bookmarks",
      icon: SvgPicture.asset("../../../../assets/icons/bookmark.svg"),
    ),
    Item(
      item: "Change Password",
      icon: SvgPicture.asset("../../../../assets/icons/key.svg"),
    ),
    Item(
      item: "Update Profile",
      icon: SvgPicture.asset("../../../../assets/icons/user-circle.svg"),
    ),
    Item(
      item: "Verify Account",
      icon: SvgPicture.asset("../../../../assets/icons/checkmark-circle.svg"),
    ),
    Item(
      item: "Term & Conditions",
      icon: SvgPicture.asset("../../../../assets/icons/file-alt.svg"),
    ),
    Item(
      item: "About Us",
      icon: SvgPicture.asset("../../../../assets/icons/material-info.svg"),
    ),
  ];

  @override
  void initState() {
    _a = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: (_a == 3) ? ChangePassword() : UpdateProfile(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Color.fromARGB(255, 250, 249, 249),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(width: 20),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/setting.svg",
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "More",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontFamily: "Family Name",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 500,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: (_seletedItem == index) ? kPrimaryColor : null,
                      child: ListTile(
                        onTap: () {
                          _seletedItem = index;
                          if (index == 3) {
                            setState(() {
                              _a = 3;
                            });
                            _scaffoldKey.currentState?.openEndDrawer();
                          } else if (index == 4) {
                            setState(() {
                              _a = 4;
                            });
                            _scaffoldKey.currentState?.openEndDrawer();
                          } else {
                            setState(() {
                              _index = index;
                            });
                          }
                        },
                        title: Text(items[index].item),
                        // leading:
                        //     SvgPicture.asset("icons/${items[index].item}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(width: 30),
          (_index == 0)
              ? Expanded(
                  child: Resume(),
                )
              : Container(),
          (_index == 1)
              ? Expanded(
                  child: Container(),
                )
              : Container(),
          (_index == 2)
              ? Expanded(
                  child: Container(),
                )
              : Container(),
          (_index == 5)
              ? Expanded(
                  child: Container(),
                )
              : Container(),
          (_index == 6)
              ? Expanded(
                  child: TermCondition(),
                )
              : Container(),
          (_index == 7)
              ? Expanded(
                  child: AboutUs(),
                )
              : Container(),
          SizedBox(width: 10),
          Container(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: 220,
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Additional Features",
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                        ),
                      ),
                      // color: Colors.pink,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 300,
                      width: 220,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  child: Image.asset(
                                    "../../../../assets/icons/open-document.png",
                                  ),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),
                                Text("Application Applied"),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  child: Image.asset(
                                    "../../../../assets/icons/awesome-ambulance.png",
                                  ),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text("Emergency Contacts"),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  child: Image.asset(
                                    "../../../../assets/icons/awesome-hashtag.png",
                                  ),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18),
                                Text("Pre-fix & Command"),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  child: Image.asset(
                                    "../../../../assets/icons/awesome-pastafarianism.png",
                                  ),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text("Covid-19 Update"),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  child: Image.asset(
                                    "../../../../assets/icons/awesome-calendar-alt.png",
                                  ),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.transparent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18),
                                Text("Policy Holidays"),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.38),
                InkWell(
                  onTap: () {
                    _updatePage();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("language".tr),
                        SizedBox(width: 10),
                        Get.locale == Locale('en', 'US')
                            ? Container(
                                width: 35,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/uk.png"),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(
                                width: 35,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/cambodia.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ElevatedButton.icon(
                  onPressed: () async {
                    var response = await signout();
                    if (response == 200) {
                      Get.snackbar("Logout", "Success");
                      await _prefs.removeState("user");
                      Get.to(LoginScreen());
                    }
                  },
                  icon: Icon(Icons.login_rounded),
                  label: Text("Log out"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _updatePage() async {
  final PrefService _prefs = PrefService();
  var localKhmer = Locale('km', 'KH');
  var localEnglish = Locale('en', 'US');
  if (Get.locale == localEnglish) {
    _prefs.createState("local", "km");
    Get.updateLocale(localKhmer);
  } else {
    _prefs.createState("local", "en");
    Get.updateLocale(localEnglish);
  }
}

class Item {
  final String item;
  final SvgPicture icon;

  Item({
    required this.item,
    required this.icon,
  });
}
