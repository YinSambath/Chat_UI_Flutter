import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Views/Screens/Chat/components/Widget/create_contact.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class ContactsList extends StatefulWidget {
  @override
  State<ContactsList> createState() => ContactsListState();
}

class ContactsListState extends State<ContactsList> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      // endDrawer: CreateContact(),
      backgroundColor: Colors.transparent,
      body: Container(
        height: 580,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _scaffoldKey.currentState?.openEndDrawer();
                  });
                },
                child: Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17.9),
                        child: SvgPicture.asset(
                            "../../../../../../assets/icons/material-person-add.svg"),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Add Contact",
                        style: TextStyle(
                          fontFamily: "Family Name",
                          fontSize: 17,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SvgPicture.asset(
                  "../../../../../../assets/icons/divider.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
