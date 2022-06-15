import 'package:mcircle_project_ui/chat_app.dart';

class GroupInformation extends StatefulWidget {
  GroupInformation({Key? key}) : super(key: key);
  @override
  State<GroupInformation> createState() => _GroupInformationState();
}

const List<Tab> groupTabs = <Tab>[
  Tab(text: "Members"),
  Tab(text: "Photos"),
  Tab(text: "Files"),
  Tab(text: "Voice"),
  Tab(text: "Links"),
];

class _GroupInformationState extends State<GroupInformation> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: groupTabs.length,
      child: Scaffold(
        appBar: TabBar(
          tabs: groupTabs,
          indicatorColor: kPrimaryColor,
          labelStyle: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Family Name',
          ),
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey, //For Selected tab
          unselectedLabelStyle: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Family Name',
          ),
        ),
        body: TabBarView(
          children: groupTabs.map((Tab tab) {
            return Center(
              child: Text(
                '${tab.text} Tab',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
