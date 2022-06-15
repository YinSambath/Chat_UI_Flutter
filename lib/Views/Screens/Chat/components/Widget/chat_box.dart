import 'package:mcircle_project_ui/chat_app.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);
  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return MessageItem(
            sentByMe: true,
          );
        },
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  MessageItem({
    Key? key,
    required this.sentByMe,
  }) : super(key: key);
  final bool sentByMe;

  @override
  Widget build(BuildContext context) {
    Color white = Colors.white;
    Color black = Colors.black;
    Color? grey = Colors.grey[400];

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 1.5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: sentByMe ? kPrimaryColor : grey,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Hello",
              style: TextStyle(
                color: sentByMe ? white : black,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "11:34 AM",
              style: TextStyle(
                color: (sentByMe ? white : black).withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
