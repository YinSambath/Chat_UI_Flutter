import 'package:mcircle_project_ui/chat_app.dart';

class ChatInfoPrivate extends StatefulWidget {
  ChatInfoPrivate({Key? key}) : super(key: key);
  @override
  State<ChatInfoPrivate> createState() => _ChatInfoPrivateState();
}

class _ChatInfoPrivateState extends State<ChatInfoPrivate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      width: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: PrivateInformation(),
          ),
        ],
      ),
    );
  }
}
