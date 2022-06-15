import 'package:mcircle_project_ui/chat_app.dart';

class ChatInfoGroup extends StatefulWidget {
  ChatInfoGroup({Key? key}) : super(key: key);
  @override
  State<ChatInfoGroup> createState() => _ChatInfoGroupState();
}

class _ChatInfoGroupState extends State<ChatInfoGroup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(width: 45, height: 40),
          // container for group action (add member, mute, leave group)
          Container(
            height: 60,
            width: 420,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: kPrimaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add),
                        Text("Add"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: kPrimaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off),
                        Text("Mute"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: kPrimaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.output_rounded),
                        Text("Leave"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 45, height: 10),
          // container for display in group chat
          Container(
            height: 450,
            width: 420,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: GroupInformation(),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          //
        ],
      ),
    );
  }
}
