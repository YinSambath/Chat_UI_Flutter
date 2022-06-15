import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:mcircle_project_ui/Views/Screens/More/profile_page.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/productivity_screen.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class SideBar extends StatefulWidget {
  final UserModel userData;

  const SideBar({Key? key, required this.userData}) : super(key: key);
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedIndex = 0;
  PageController page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 18, 12, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SideMenu(
                controller: page,
                style: SideMenuStyle(
                  displayMode: SideMenuDisplayMode.compact,
                  iconSize: 40,
                  hoverColor: Colors.transparent,
                  selectedIconColor: kPrimaryColor,
                  compactSideMenuWidth: 70,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 200,
                      ),
                      child: Image.asset(
                        "assets/images/logo makfood & mcircle.png",
                      ),
                    ),
                    SizedBox(height: 150),
                  ],
                ),
                items: [
                  SideMenuItem(
                    priority: 0,
                    title: 'Chat',
                    onTap: () => page.jumpToPage(0),
                    icon: Icon(Icons.message),
                  ),
                  SideMenuItem(
                      priority: 1,
                      title: 'Users',
                      onTap: () => page.jumpToPage(1),
                      icon: Icon(Icons.checklist_rounded)),
                  SideMenuItem(
                    priority: 2,
                    title: 'Files',
                    onTap: () {},
                    icon: Icon(Icons.file_copy_rounded),
                  ),
                  SideMenuItem(
                    priority: 3,
                    title: 'Download',
                    onTap: () {},
                    icon: Icon(Icons.download),
                  ),
                  SideMenuItem(
                    priority: 4,
                    title: 'Settings',
                    onTap: () => page.jumpToPage(4),
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: PageView(
                controller: page,
                children: [
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Chat(userData: widget.userData),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Productivity(),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Page\n   3',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Page\n   4',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: MoreScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
