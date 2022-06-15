import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Models/meeting_model.dart';
import 'package:mcircle_project_ui/Models/planning_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/action.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/action_meeting.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/action_planning.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_folders.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_trips_actios.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/meeting_list.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/planning_list.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/short_all.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/short_today.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/show_more_all.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/todo.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/todo_folder.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/trip_list.dart';
import 'package:mcircle_project_ui/constants.dart';

class Productivity extends StatefulWidget {
  const Productivity({
    Key? key,
  }) : super(key: key);
  // final FolderModel folder;

  @override
  State<Productivity> createState() => _ProductivityState();
}

class _ProductivityState extends State<Productivity> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _d = 0;
  int _widget = 0;
  FolderModel? _folder;
  int _getWidget = 0;
  TripModel? _trip;
  MeetingModel? _meeting;
  PlanningModel? _planning;
  int? isSelected;
  int? isSelected1;
  callback(FolderModel newIdex) {
    setState(() {
      _folder = newIdex;
      _widget = 0;
    });
  }

  callback1(TripModel tripIdex) {
    setState(() {
      _trip = tripIdex;
      _widget = 7;
    });
  }

  callback2(MeetingModel meetingIdex) {
    setState(() {
      _meeting = meetingIdex;
      _widget = 8;
    });
  }

  callback3(PlanningModel planningIdex) {
    setState(() {
      _planning = planningIdex;
      _widget = 9;
    });
  }

  callbackWidget(int value) {
    setState(() {
      _widget = value;
      _trip == null;
    });
  }

  callbackWidget1(int value) {
    setState(() {
      _widget = value;
      _folder == null;
    });
  }

  callbackWidget2(int value) {
    setState(() {
      _widget = value;
      _meeting == null;
    });
  }

  callbackWidget3(int value) {
    setState(() {
      _widget = value;
      _planning == null;
    });
  }

  callBackSeeMore(int value) {
    setState(() {
      _getWidget = value;
      _widget = 10;
      print(value);
    });
  }
  backToSeeMore(int value) {
    setState(() {
      _widget = value;
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: (_d == 0) ? CreateFolder() : CreateTripAction(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Color.fromARGB(255, 250, 249, 249),
      body: Row(
        children: [
          Column(
            children: [
              Container(
                width: 300,
                height: 40,
                child: Row(
                  children: [
                    SvgPicture.asset(
                        "../../../../assets/icons/Icon-awesome-task.svg"),
                    SizedBox(width: 10),
                    Text(
                      "Productivity",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Family Name",
                      ),
                    ),
                    SizedBox(width: 129),
                    Container(
                      width: 40,
                      height: 40,
                      child: PopupMenuButton<int>(
                        elevation: 0,
                        splashRadius: 1,
                        offset: Offset.zero,
                        position: PopupMenuPosition.under,
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: kPrimaryColor),
                                SizedBox(width: 8),
                                Text("New Todo")
                              ],
                            ),
                            value: 0,
                          ),
                          PopupMenuItem<int>(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: kPrimaryColor),
                                SizedBox(width: 8),
                                Text("New Trip")
                              ],
                            ),
                            value: 1,
                          ),
                          PopupMenuItem<int>(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: kPrimaryColor),
                                SizedBox(width: 8),
                                Text("New Meeting")
                              ],
                            ),
                            value: 2,
                          ),
                          PopupMenuItem<int>(
                            child: Row(children: [
                              Icon(Icons.edit, color: kPrimaryColor),
                              SizedBox(width: 8),
                              Text("New Plan")
                            ]),
                            value: 3,
                          ),
                        ],
                        onCanceled: () {},
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              setState(() {
                                _d = 0;
                              });
                              _scaffoldKey.currentState?.openEndDrawer();
                              break;
                            case 1:
                              setState(() {
                                _d = 1;
                              });
                              _scaffoldKey.currentState?.openEndDrawer();
                              break;
                            case 2:
                              _scaffoldKey.currentState?.openEndDrawer();
                              break;
                            case 3:
                              _scaffoldKey.currentState?.openEndDrawer();
                              break;
                          }
                        },
                        icon: SvgPicture.asset(
                            "../../../../../assets/icons/plus.svg"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            width: 275,
                            height: 50,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: (isSelected == index)
                                    ? kPrimaryColor
                                    : null,
                              ),
                              child: ListTile(
                                  leading: (index == 0)
                                      ? Icon(Icons.phone_iphone_rounded,
                                          color: Colors.black)
                                      : (Icon(Icons.list, color: Colors.black)),
                                  title: (index == 0)
                                      ? Text("Today",
                                          style: TextStyle(color: Colors.black))
                                      : (Text("All",
                                          style:
                                              TextStyle(color: Colors.black))),
                                  onTap: () {
                                    setState(() {
                                      isSelected = index;
                                      isSelected1 = 5;
                                    });
                                    (index == 0)
                                        ? (_widget = 1)
                                        : (_widget = 2);
                                  }),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 490,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              width: 275,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color:
                                    (isSelected1 == i) ? kPrimaryColor : null,
                              ),
                              child: ListTile(
                                tileColor: kPrimaryColor,
                                leading: (i == 0)
                                    ? (Icon(Icons.calendar_today_outlined))
                                    : (i == 1)
                                        ? (Icon(Icons
                                            .transfer_within_a_station_sharp))
                                        : (i == 2)
                                            ? (Icon(Icons.meeting_room_sharp))
                                            : (Icon(
                                                Icons.photo_library_rounded)),
                                title: (i == 0)
                                    ? (Text("Todos"))
                                    : (i == 1)
                                        ? (Text("Trips"))
                                        : (i == 2)
                                            ? (Text("Meetings"))
                                            : (Text("Plans")),
                                onTap: () {
                                  setState(
                                    () {
                                      isSelected1 = i;
                                      isSelected = 3;
                                      (i == 0)
                                          ? (_widget = 3)
                                          : (i == 1)
                                              ? (_widget = 4)
                                              : (i == 2)
                                                  ? (_widget = 5)
                                                  : (_widget = 6);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 24),
          (_widget == 1) ? ShortToday() : SizedBox(),
          (_widget == 2) ? ShortAll(seeMore: callBackSeeMore,) : (_widget == 10 )?SeeMore(back: backToSeeMore, getWidget: _getWidget,):SizedBox(),
          (_widget == 3)
              ? TodoList(callback: callback)
              : (_widget == 0 && _folder != null)
                  ? Todo(folder: _folder!, widget: callbackWidget)
                  : SizedBox(),
          (_widget == 4)
              ? TripList(callback1: callback1)
              : (_widget == 7 && _trip != null)
                  ? ActionList(
                      trip: _trip!,
                      widget1: callbackWidget1,
                    )
                  : SizedBox(),
          (_widget == 5)
              ? MeetingList(callback2: callback2)
              : (_widget == 8 && _meeting != null)
                  ? ActionMeetingList(
                      widget2: callbackWidget2, meeting: _meeting!)
                  : SizedBox(),
          (_widget == 6)
              ? PlanningList(callback3: callback3)
              : (_widget == 9 && _planning != null)
                  ? ActionPlanningList(
                      widget3: callbackWidget3, planning: _planning!)
                  : SizedBox(),
        ],
      ),
    );
  }
}
