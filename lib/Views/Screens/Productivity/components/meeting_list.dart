import 'package:mcircle_project_ui/Models/meeting_model.dart';
import 'package:mcircle_project_ui/Providers/meeting_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_meeting.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_trips_actios.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mcircle_project_ui/chat_app.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

class MeetingList extends StatefulWidget {
  Function(MeetingModel)? callback2;
  MeetingList({
    Key? key,
    this.callback2,
  }) : super(key: key);
  // FolderModel seletedFolder;
  @override
  State<MeetingList> createState() => _MeetingListState();
}

class _MeetingListState extends State<MeetingList> {
  int _d = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int indexList = 0;
  int page = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MeetingProvider>(context, listen: false).getMeetingData(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1095,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CreateMeetingAction(),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Color.fromARGB(255, 250, 249, 249),
        body: Column(
          children: [
            Container(
              width: 1095,
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(11)),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Meeting"),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 250,
                        child: TextFormField(
                          onChanged: (value) async {
                            String search = value;
                            final response = await searchMeeting(search);
                            if (response != null) {
                              Provider.of<MeetingProvider>(context,
                                      listen: false)
                                  .getSearchMeeting(search);
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.0)),
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11.0)),
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            hintText: "Search",
                            suffixIcon:
                                Icon(Icons.search, color: kPrimaryColor),
                            filled: true,
                          ),
                        ),
                        // color: Colors.pink,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Text("New Meeting"),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 550,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text("Task"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Text("Start-DateTime"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Text("End-DateTime"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Text("Location"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 6,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("Reminder"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Text("Progress"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Text("File"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: Text("Note"),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Text("Updated"),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Divider(color: kPrimaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Consumer<MeetingProvider>(
                            builder: (__, notifier, child) {
                          if (notifier.state == NotifierState.loading) {
                            child = Container(
                              height: 400,
                              child: SpinKitRotatingCircle(
                                color: kPrimaryColor,
                                size: 50.0,
                              ),
                            );
                          } else if (notifier.meetingData != null &&
                              notifier.meetingData!.data!.isNotEmpty &&
                              notifier.state == NotifierState.loaded) {
                            child = Container(
                              height: 400,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: notifier.meetingData!.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    MeetingModel _meeting =
                                        notifier.meetingData!.data![index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.callback2!(notifier
                                              .meetingData!.data![index]);
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: Text(
                                                  (_meeting.title!.length >= 15)
                                                      ? (_meeting.title!
                                                              .substring(
                                                                  0, 15) +
                                                          "...")
                                                      : (_meeting.title!),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                child: Text(
                                                  (_meeting.startDate != null &&
                                                          _meeting.startDate!
                                                              .isNotEmpty)
                                                      ? (_meeting.startDate!)
                                                      : ("N/A"),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                child: Text(
                                                  (_meeting.endDate != null &&
                                                          _meeting.endDate!
                                                              .isNotEmpty)
                                                      ? (_meeting.endDate!
                                                          .substring(0, 6))
                                                      : ("N/A"),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                child: Text(
                                                  (_meeting.location!.length >=
                                                          15)
                                                      ? (_meeting.location!
                                                              .substring(
                                                                  0, 15) +
                                                          "...")
                                                      : (_meeting.location!),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                child: FlutterSwitch(
                                                  activeColor: kPrimaryColor,
                                                  padding: 0,
                                                  width: 55.0,
                                                  height: 25.0,
                                                  valueFontSize: 12.0,
                                                  toggleColor:
                                                      kPrimaryLightColor,
                                                  // toggleSize: 18.0,
                                                  value: _meeting.reminder!,
                                                  onToggle: (val) async {
                                                    String meetingId =
                                                        _meeting.sId!;
                                                    bool reminder = val;
                                                    var response =
                                                        await meetingReminder(
                                                            meetingId,
                                                            reminder);
                                                    if (response != null) {
                                                      Provider.of<MeetingProvider>(
                                                              context,
                                                              listen: false)
                                                          .createUpdate(
                                                              response);
                                                    }
                                                    ;
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: Text(
                                                    "${_meeting.progress}%"),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                child: Text("N/A"),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: Text(
                                                  (_meeting.note!.length >= 15)
                                                      ? (_meeting.note!
                                                              .substring(
                                                                  0, 15) +
                                                          "...")
                                                      : (_meeting.note!),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: (_meeting.updatedDate !=
                                                            null &&
                                                        _meeting.updatedDate!
                                                            .isNotEmpty)
                                                    ? Text(_meeting.updatedDate!
                                                        .substring(0, 6))
                                                    : Text("N/A"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            child = Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 250,
                                height: 250,
                                child: Image.asset(
                                    "../../../../../assets/images/98560-empty.gif"),
                              ),
                            );
                          }
                          return child;
                        }),
                      ),
                    ),
                    Consumer<MeetingProvider>(builder: (__, notifier, child) {
                      List<List<int>> listPage = [];
                      List<int> storeIndexPage = [];
                      if (notifier.meetingData != null &&
                          notifier.meetingData!.data != null &&
                          notifier.meetingData!.data!.isNotEmpty) {
                        if (listPage == [] ||
                            listPage.isEmpty && storeIndexPage == [] ||
                            storeIndexPage.isEmpty) {
                          for (var i = 0;
                              i < notifier.meetingData!.totalPages!;
                              i++) {
                            if (i == 0 ) {
                              storeIndexPage.add(i + 1);
                            } else if (notifier.meetingData!.totalDocs! > 10 && notifier.meetingData!.totalDocs! % 10 != 0) {
                              storeIndexPage.add(i + 1);
                            } else if (i % 8 == 0) {
                              listPage.add(storeIndexPage);
                              storeIndexPage = [];
                              storeIndexPage.add(i + 1);
                            } else {
                              storeIndexPage.add(i + 1);
                            }
                            if (i + 1 == notifier.meetingData!.totalPages!) {
                              if (storeIndexPage.isNotEmpty) {
                                listPage.add(storeIndexPage);
                              }
                            }
                          }
                        }
                        child = Container(
                          width: 250,
                          child: Row(
                            children: [
                              (indexList > 0)
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          indexList -= 1;
                                        });
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            right: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Icon(Icons
                                            .keyboard_double_arrow_left_sharp),
                                      ),
                                    )
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          bottomLeft: Radius.circular(9),
                                        ),
                                        border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          right: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          left: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Icon(Icons
                                          .keyboard_double_arrow_left_sharp),
                                    ),
                              (listPage == [] ||
                                      listPage.isEmpty &&
                                          storeIndexPage == [] ||
                                      storeIndexPage.isEmpty)
                                  ? (Container(color: Colors.white))
                                  : Row(
                                      children: List.generate(
                                        listPage[indexList].length,
                                        (index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                page =
                                                    listPage[indexList][index];
                                              });
                                              Provider.of<MeetingProvider>(
                                                      context,
                                                      listen: false)
                                                  .getMeetingData(page);
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                  right: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                  left: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                              ),
                                              child: Text(
                                                  "${listPage[indexList][index]}"),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              (notifier.meetingData!.totalPages! >
                                          listPage[indexList].length &&
                                      listPage[indexList].length == 8)
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          indexList = indexList + 1;
                                        });
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(9),
                                            bottomRight: Radius.circular(9),
                                          ),
                                          border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            right: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Icon(Icons
                                            .keyboard_double_arrow_right_sharp),
                                      ),
                                    )
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(9),
                                          bottomRight: Radius.circular(9),
                                        ),
                                        border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          right: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          left: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Icon(Icons
                                          .keyboard_double_arrow_right_sharp),
                                    ),
                            ],
                          ),
                          // ),
                        );
                      } else {
                        child = Container(color: Colors.white);
                      }
                      return child;
                    }),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
