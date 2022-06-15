import 'dart:developer';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/message.dart';
import 'package:mcircle_project_ui/Providers/contact_provider.dart';
import 'package:mcircle_project_ui/Providers/message_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Chat/components/Widget/create_contact.dart';
import 'package:mcircle_project_ui/Views/Screens/Chat/components/Widget/update_contact.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:rflutter_alert/rflutter_alert.dart';
class Body extends StatefulWidget {
  Body({Key? key, required this.userData}) : super(key: key);
  final UserModel userData;
  @override
  State<Body> createState() => _BodyState();
}

List<Tab> chatOrContact = <Tab>[
  Tab(
    // icon: SvgPicture.asset("../../../../../assets/icons/chat.svg"),
    text: "Chats",
  ),
  Tab(
    // icon: SvgPicture.asset("../../../../../assets/icons/bookmark.svg"),
    text: "Contacts",
  ),
];

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late ContactProvider userId;
  late bool _info;
  int _index = 0;
  String _msgOrVoice = "";
  bool _trailing = false;
  late int _selected;
  int _drawer = 0;
  final TextEditingController _msgController = TextEditingController();
  final PrefService _prefs = PrefService();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ContactModel? seletedContext;
  late IO.Socket socket;
  TextEditingController testController = TextEditingController();
  var targetId;
  @override
  void initState() {
    targetId = (testController.text.isNotEmpty) ?  testController.text: "AB";

    _info = false;
    super.initState();
    initializeSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ContactProvider>(context, listen: false).getContactData();
    });
   
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void initializeSocket() async {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    socket = IO.io("http://127.0.0.1:3000", IO.OptionBuilder().setTransports(['websocket']).setQuery({'username': "${_userData.firstname} ${_userData.lastname}", 'userId': _userData.sId}).build());
    socket.connect(); //connect the Socket.IO Client to the Server
  
    //SOCKET EVENTS
    // --> listening for connection
    socket.on('connect', (data) {
      print(socket.connected);
      // print(data);
      // socket.on(targetId, (message)=>{r
      //   // _msgController
      //   print(targetId+'-'+message)
      // });
    });

    socket.on(targetId, (data) => {
      Provider. of<MessageProvider>(context, listen: false).addNewMessage(Message.fromJson(data))
    });

    //listen for incoming messages from the Server.
    socket.on('message', (data) => Provider. of<MessageProvider>(context, listen: false).addNewMessage(Message.fromJson(data)));

    //listens when the client is disconnected from the Server
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  sendMessage(String message) async {
    if (!mounted) {
      print("setter section");
      return;
    }
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var message = {
        "targetId": targetId,
        "message": _msgController.text.trim(), //--> message to be sent
        "username": "${_userData.firstname} ${_userData.lastname}",
        "senderId": _userData.sId,
        "sentAt": DateTime.now().toLocal().toString().substring(0,16),
      };
      print(message);
    socket.emit(
      "message",
      message,
    );
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: (_drawer == 1)
          ? CreateContact()
          : (seletedContext != null)
              ? UpdateContact(
                  contact: seletedContext!,
                )
              : SizedBox(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Color.fromARGB(255, 250, 249, 249),
      body: Row(
        children: [
          Column(
            children: [
              SizedBox(width: 45),
              // container for search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    // constraints: BoxConstraints(maxWidth: 250),
                    child: TextFormField(
                      onChanged: (value) async {
                        String search = value;
                        if (_index == 1) {
                          final response = await searchContact(search);
                          if (response != null) {
                            Provider.of<ContactProvider>(context, listen: false)
                                .getSearchContact(search);
                          }
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11.0)),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11.0)),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        hintText: "Search",
                        suffixIcon: Icon(Icons.search, color: kPrimaryColor),
                        filled: true,
                      ),
                    ),
                    // color: Colors.pink,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(
                          "../../../../../assets/icons/plus.svg"),
                    ),
                  )
                ],
              ),
              SizedBox(width: 45, height: 10),

              // for chat or contact
              DefaultTabController(
                length: chatOrContact.length,
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 580,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: ChatMember(),
                          ),
                          SingleChildScrollView(
                            child: Container(
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
                                        setStateIfMounted(() {
                                          if (!mounted){
                                            print("setter section");
                                            return;
                                          }
                                          _drawer = 1;
                                          _scaffoldKey.currentState
                                              ?.openEndDrawer();
                                        });
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 17.9),
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
                                  Consumer<ContactProvider>(
                                      builder: (__, notifier, child) {
                                    if (notifier.state ==
                                        NotifierState.loading) {
                                      child = const Center(
                                        child: SpinKitRotatingCircle(
                                          color: kPrimaryColor,
                                        ),
                                      );
                                    } else if (notifier.contactData != null &&
                                        notifier
                                            .contactData!.data!.isNotEmpty &&
                                        notifier.state ==
                                            NotifierState.loaded) {
                                      child = Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: notifier
                                              .contactData!.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            ContactModel _contact = notifier
                                                .contactData!.data![index];
                                           
                                            return InkWell(
                                              onHover: (value) {
                                                if (value) {
                                                  _trailing = true;
                                                  _selected = index;
                                                  setStateIfMounted(() {
                                                    if (!mounted){
                                                      print("setter section");
                                                      return;
                                                    }
                                                  });
                                                } else {
                                                  _trailing = false;
                                                  Future.delayed(
                                                      Duration(seconds: 60),
                                                      () {
                                                    setStateIfMounted(() {
                                                      if (!mounted){
                                                        print("setter section");
                                                        return;
                                                      }
                                                    });
                                                  });
                                                }
                                              },
                                              onTap: () {
                                                print("Tap");
                                              },
                                              child: Container(
                                                width: 300,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      child: Container(
                                                        height: 50,
                                                        alignment:
                                                            Alignment.center,
                                                        child: ListTile(
                                                          leading: CircleAvatar(
                                                            child: Text(
                                                              (_contact.firstname!.isNotEmpty && _contact.lastname!.isNotEmpty)
                                                                ? ("${_contact.firstname![0].toUpperCase()}${_contact.lastname![0].toUpperCase()}")
                                                                  :(_contact.firstname!.isNotEmpty && _contact.lastname!.isEmpty)
                                                                  ?("${_contact.firstname![0].toUpperCase()}") 
                                                                  :(_contact.firstname!.isEmpty && _contact.lastname!.isNotEmpty)
                                                                  ?("${_contact.lastname![0].toUpperCase()}")
                                                                : (""),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          title: Text(
                                                              "${_contact.firstname} ${_contact.lastname}"),
                                                          subtitle: Text(
                                                              "${_contact.phone}"),
                                                          trailing:
                                                              (_trailing ==
                                                                      true)
                                                                  ? Visibility(
                                                                      visible:
                                                                          _selected ==
                                                                              index,
                                                                      child: PopupMenuButton<
                                                                          int>(
                                                                        position:
                                                                            PopupMenuPosition.under,
                                                                        itemBuilder:
                                                                            (context) =>
                                                                                [
                                                                          PopupMenuItem<
                                                                              int>(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(Icons.edit, color: kPrimaryColor),
                                                                                SizedBox(width: 8),
                                                                                Text("Update")
                                                                              ],
                                                                            ),
                                                                            value:
                                                                                0,
                                                                          ),
                                                                          PopupMenuItem<
                                                                              int>(
                                                                            child:
                                                                                Row(children: [
                                                                              Icon(Icons.delete, color: kPrimaryColor),
                                                                              SizedBox(width: 8),
                                                                              Text("Delete")
                                                                            ]),
                                                                            value:
                                                                                1,
                                                                          ),
                                                                        ],
                                                                        onSelected:
                                                                            (value) {
                                                                          switch (
                                                                              value) {
                                                                            case 0:
                                                                              setStateIfMounted(() {
                                                                                if (!mounted){
                                                                                  print("setter section");
                                                                                  return;
                                                                                }
                                                                                _drawer = 2;
                                                                                seletedContext = notifier.contactData!.data![index];
                                                                                _scaffoldKey.currentState?.openEndDrawer();
                                                                              });
                                                                              break;
                                                                            case 1:
                                                                              Alert(
                                                                                context: context,
                                                                                type: AlertType.warning,
                                                                                title: "Comfirmation",
                                                                                desc: "Are you sure you want to delete this contact?",
                                                                                buttons: [
                                                                                  DialogButton(
                                                                                    child: Text(
                                                                                      "No",
                                                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                                    ),
                                                                                    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  DialogButton(
                                                                                    child: Text(
                                                                                      "Yes",
                                                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      String sId = _contact.sId!;
                                                                                      var response = await deleteContact(sId).whenComplete(() => {
                                                                                            setStateIfMounted(() {
                                                                                              if (!mounted){
                                                                                                print("setter section");
                                                                                                return;
                                                                                              }
                                                                                              Navigator.pop(context);
                                                                                              notifier.contactData!.data!.removeAt(index);
                                                                                            })
                                                                                          });
                                                                                      if (response == 200) {
                                                                                        print("Done");
                                                                                      }
                                                                                    },
                                                                                    color: Colors.green,
                                                                                  )
                                                                                ],
                                                                              ).show();
                                                                              break;
                                                                          }
                                                                        },
                                                                      ),
                                                                    )
                                                                  : Text(""),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30),
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
                                      child =
                                          const Center(child: Text("No data"));
                                    }
                                    return child;
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 45, height: 10),
                    Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TabBar(
                        tabs: chatOrContact,
                        onTap: (int) {
                          switch (int) {
                            case 0:
                              setStateIfMounted(() {
                                if (!mounted){
                                  print("setter section");
                                  return;
                                }
                                _index = 0;
                              });
                              break;
                            case 1:
                              listContact();
                              setStateIfMounted(() {
                                if (!mounted){
                                  print("setter section");
                                  return;
                                }
                                _index = 1;
                              });
                              break;
                          }
                        },
                        unselectedLabelColor: Colors.grey, //For Selected tab
                        unselectedLabelStyle: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Family Name',
                        ),
                        indicatorColor: Colors.transparent,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Family Name',
                        ),
                        labelColor: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // ContactsList(),

              // container for bottom bar
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              width: 1300,
              child: Column(
                children: [
                  SizedBox(width: 45),
                  // container for Put chat name or group name
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 8, 8, 8),
                          child: InkWell(
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 10),
                                Text("${targetId}"),
                                RoundedInputField(hintText: "input your name", width: 80, height: 50, controller: testController, onChanged: (value) {
                                 setState(() {
                                   targetId = ( value.isNotEmpty)? value : "AB";
                                   
                                 });
                                },),
                              ],
                            ),
                            onTap: () {
                              setStateIfMounted(() {
                                if (!mounted){
                                  print("setter section");
                                  return;
                                }
                                _info = !_info;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("icons/mute.svg"),
                        ),
                      ],
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(width: 45, height: 10),
                  Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Consumer<MessageProvider>(
                builder: (_, provider, __) => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final message = provider.messages[index];
                    
                    return Wrap(
                      alignment: message.senderId == widget.userData.sId
                          ? WrapAlignment.end
                          : WrapAlignment.start,
                      children: [
                        
                        Card(
                          color: message.senderId == widget.userData.sId
                              ? kPrimaryColor
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                                  message.senderId == widget.userData.sId
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(message.message, style: TextStyle(
                                  color: 
                                    message.senderUsername == "${widget.userData.firstname} ${widget.userData.lastname}"
                                      ?Colors.white
                                      :Colors.black
                                  ),
                                ),
                                Text(
                                  (message.sentAt.toString()),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: provider.messages.length,
                ),
              ),
            ),
          ),
                  SizedBox(width: 45, height: 10),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('icons/file.svg'),
                            color: kPrimaryColor,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                          SizedBox(width: 5),
                          // place for send message
                          WriteMessage(
                            hintText: "Write a message...",
                            controller: _msgController,
                            onChanged: (value) {
                              setStateIfMounted(() {
                                if (!mounted){
                                  print("setter section");
                                  return;
                                }
                                (value.isNotEmpty)
                                    ? _msgOrVoice = value
                                    : _msgOrVoice = "";
                              });
                            },
                          ),
                          SizedBox(width: 5),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: kPrimaryColor,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                          SizedBox(width: 1),
                          (_msgOrVoice == "")
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.keyboard_voice,
                                    color: kPrimaryColor,
                                  ),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                )
                              : IconButton(
                                  onPressed: () {
                                    if (!mounted) {
                                      print("setter section");
                                      return;
                                    }
                                    sendMessage(_msgController.text);
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: kPrimaryColor,
                                  ),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          (_info == true)
              ? Column(
                  children: [
                    SizedBox(
                      width: 42,
                    ),
                    Container(
                      height: 180,
                      width: 380,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset("images/person.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "ChatName",
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 42, height: 10),
                    ChatInfoPrivate(),
                  ],
                )
              : SizedBox()

          // SizedBox(width: 10),
        ],
      ),
    );
  }
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
}
