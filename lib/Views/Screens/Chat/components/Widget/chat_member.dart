import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class ChatMember extends StatefulWidget {
  @override
  State<ChatMember> createState() => ChatMemberState();
}

class ChatMemberState extends State<ChatMember> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 630,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    width: 300,
                    height: 50,
                    alignment: Alignment.center,
                    child: ListTile(
                      leading: Icon(Icons.list),
                      trailing: Text(
                        "GFG",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text("List item $index"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SvgPicture.asset(
                      "../../../../../../assets/icons/divider.svg"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
