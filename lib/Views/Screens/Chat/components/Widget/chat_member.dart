import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Models/message.dart';
import 'package:mcircle_project_ui/Providers/message_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';

import 'package:mcircle_project_ui/Providers/chat_member_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../Configs/enum.dart';

class ChatMember extends StatefulWidget {
  late Function callbackId;
  ChatMember({Key? key, required this.callbackId}) : super(key: key);
  @override
  State<ChatMember> createState() => ChatMemberState();
}

class ChatMemberState extends State<ChatMember> {
  final PrefService _prefs = PrefService();
  var userId;
  @override
  void initState() {
    super.initState();
    setUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatMemberProvider>(context, listen: false).getChatData();
    });
  }

  Future setUserId() async {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    setState(() {
      userId = _userData.sId;
    });
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
        child: SingleChildScrollView(
          child: Consumer<ChatMemberProvider>(builder: (__, notifier, child) {
            if (notifier.state == NotifierState.loading) {
              child = const Center(
                child: SpinKitRotatingCircle(
                  color: kPrimaryColor,
                ),
              );
            } else if (notifier.chatData != null &&
                notifier.chatData!.data!.isNotEmpty &&
                notifier.state == NotifierState.loaded) {
              child = Padding(
                padding: const EdgeInsets.all(1),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notifier.chatData!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatModel _chat = notifier.chatData!.data![index];

                    return InkWell(
                      onTap: () async {
                        // Provider.of<MessageProvider>(context, listen: false)
                        //     .getPrivateChatData("625f79f18f1c3e5be0c0bb0b");
                        if (_chat.person1Id == userId) {
                          Provider.of<MessageProvider>(context, listen: false)
                              .getPrivateChatData(_chat.person2Id);
                          setState(() {
                            widget.callbackId(
                                _chat.person2Id, _chat.person2Name);
                          });
                        } else if (_chat.person2Id == userId) {
                          Provider.of<MessageProvider>(context, listen: false)
                              .getPrivateChatData(_chat.person1Id);
                          setState(() {
                            widget.callbackId(
                                _chat.person1Id, _chat.person1Name);
                          });
                        } else {
                          print("Error");
                        }
                      },
                      child: Container(
                        width: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      userId == _chat.person2Id
                                          ? (_chat.person1Name != ""
                                              ? _chat.person1Name[0]
                                              : "CM")
                                          : (_chat.person2Name != ""
                                              ? _chat.person2Name[0]
                                              : "CM"),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  title: Text((userId == _chat.person2Id
                                      ? _chat.person1Name
                                      : _chat.person2Name)),
                                  // subtitle: Text(_chat),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SvgPicture.asset(
                                  "../../../../../../assets/icons/divider.svg"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              child = const Center(child: Text("No data"));
            }
            return child;
          }),
        ),
      ),
    );
  }
}
