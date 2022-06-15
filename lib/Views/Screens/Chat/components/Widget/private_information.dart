import 'package:mcircle_project_ui/chat_app.dart';

class PrivateInformation extends StatefulWidget {
  PrivateInformation({Key? key}) : super(key: key);
  @override
  State<PrivateInformation> createState() => _PrivateInformationState();
}

const List<Tab> privateTabs = <Tab>[
  Tab(text: "Photos"),
  Tab(text: "Files"),
  Tab(text: "Voice"),
  Tab(text: "Links"),
];

class _PrivateInformationState extends State<PrivateInformation> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: privateTabs.length,
      child: Scaffold(
        appBar: TabBar(
          tabs: privateTabs,
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
          children: privateTabs.map((Tab tab) {
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
