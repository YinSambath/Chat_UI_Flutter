import 'package:mcircle_project_ui/Models/action_meeting_model.dart';
import 'package:mcircle_project_ui/Models/action_model.dart';
import 'package:mcircle_project_ui/Models/action_planning_model.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Models/todo_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/Providers/action_meeting_provider.dart';
import 'package:mcircle_project_ui/Providers/action_planning_provider.dart';
import 'package:mcircle_project_ui/Providers/action_provider.dart';
import 'package:mcircle_project_ui/Providers/todo_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
// import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_todos_actios.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mcircle_project_ui/chat_app.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

class ShortAll extends StatefulWidget {
  final Function seeMore;
  ShortAll({
    Key? key, required this.seeMore,
  }) : super(key: key);
  // FolderModel seletedFolder;
  @override
  State<ShortAll> createState() => _ShortAllState();
}

class _ShortAllState extends State<ShortAll> {
  // int _d = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).shortAllData();
      Provider.of<ActionProvider>(context, listen: false).shortAllData();
      Provider.of<ActionMeetingProvider>(context, listen: false).shortAllData();
      Provider.of<ActionPlanningProvider>(context, listen: false).shortAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1095,
      child: Scaffold(
        key: _scaffoldKey,
        // endDrawer: CreateTripAction(),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Color.fromARGB(255, 250, 249, 249),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Container(
                width: 1095,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(11)),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text("All"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Todo",
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  InkWell(
                    onTap:() {
                      widget.seeMore(1);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "See More",
                            style: TextStyle(color: kPrimaryColor, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.double_arrow_rounded, color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                
              SizedBox(height: 10),
              Container(
                height: 295,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Task"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("list"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("DateTime"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("End-Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Location"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Priority"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Reminder"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Progress"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("File"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Note"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Updated"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Divider(color: kPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Consumer<TodoProvider>(
                            builder: (__, notifier, child) {
                          if (notifier.state == NotifierState.loading) {
                            child = Center(
                              child: Container(
                                child: SpinKitRotatingCircle(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ),
                              ),
                            );
                          } else if (notifier.shortData != null &&
                              notifier.shortData!.data1!.isNotEmpty &&
                              notifier.state == NotifierState.loaded) {
                            child = Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: (notifier.shortData!.data1!.length > 5) ? 5 : notifier.shortData!.data1!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TodoModel _todo =
                                      notifier.shortData!.data1![index];
                                  return InkWell(
                                    // onTap: () {
                                    //   setState(() {
                                    //     widget.callback1!(
                                    //         notifier.tripData!.data![index]);
                                    //   });
                                    // },
                                    child: Container(
                                      // 
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),
                                                        value: _todo.mark,
                                                        shape: CircleBorder(),
                                                        onChanged: (bool?
                                                            value) async {
                                                        //   String planningId =
                                                        //       widget._actionMeeting
                                                        //           .sId!;
                                                        //   String actionId =
                                                        //       _actionMeeting.sId!;
                                                        //   bool mark = value!;
                                                        //   var response =
                                                        //       await markActionPlanning(
                                                        //           planningId,
                                                        //           actionId,
                                                        //           mark);
                                                        //   if (response !=
                                                        //       null) {
                                                        //     Provider.of<ActionPlanningProvider>(
                                                        //             context,
                                                        //             listen:
                                                        //                 false)
                                                        //         .createUpdate(
                                                        //             response);
                                                        //   }
                                                        },
                                                      ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              child: Text(
                                                (_todo.title!.length >= 15)
                                                    ? (_todo.title!
                                                            .substring(0, 15) +
                                                        "...")
                                                    : (_todo.title!),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: Text(
                                                (_todo.folder ==
                                                        "")
                                                    ?"N/A":(_todo.folder.name !=
                                                                null &&
                                                            _todo.folder
                                                                .name!
                                                                .isNotEmpty
                                                           )
                                                        ?(_todo.folder.name.length >=13)? (_todo.folder.name!
                                                                .substring(
                                                                    0, 11) +
                                                            "..."):(_todo.folder.name)
                                                        : "N/A",
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text((_todo.dateTime !=
                                                          null &&
                                                      _todo.dateTime!
                                                          .isNotEmpty &&
                                                      _todo.dateTime!.length >
                                                          7)
                                                  ? (_todo.dateTime!
                                                      .substring(0, 7))
                                                  : "N/A"),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text(_todo.repeat!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: Text(
                                                (_todo.endRepeat!.isNotEmpty &&
                                                        _todo.endRepeat !=
                                                            null &&
                                                        _todo.endRepeat!
                                                                .length >
                                                            7)
                                                    ? _todo.endRepeat!
                                                        .substring(0, 7)
                                                    : _todo.endRepeat!,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              child: Text(_todo.location!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text(_todo.priority!),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: FlutterSwitch(
                                                activeColor: kPrimaryColor,
                                                padding: 0,
                                                width: 55.0,
                                                height: 25.0,
                                                valueFontSize: 12.0,
                                                // toggleSize: 18.0,
                                                value: _todo.reminder!,
                                                onToggle: (val) async {
                                                  // String tripId = _todo.sId!;
                                                  // bool reminder = val;
                                                  // var response =
                                                  //     await tripReminder(
                                                  //         tripId, reminder);
                                                  // if (response != null) {
                                                  //   Provider.of<TripProvider>(
                                                  //           context,
                                                  //           listen: false)
                                                  //       .createUpdate(response);
                                                  // }
                                                  // ;
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text("${_todo.progress}%"),
                                            ),
                                          ),
                                          SizedBox(width: 2.5),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Text("N/A"),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Text(
                                                (_todo.note!.length >= 15)
                                                    ? (_todo.note!
                                                            .substring(0, 15) +
                                                        "...")
                                                    : (_todo.note!),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child:
                                                  (_todo.updatedDate != null &&
                                                          _todo.updatedDate!
                                                              .isNotEmpty &&
                                                          _todo.updatedDate!
                                                                  .length >
                                                              7)
                                                      ? Text(_todo.updatedDate!
                                                          .substring(0, 7))
                                                      : Text("N/A"),
                                            ),
                                          ),
                                          SizedBox(width: 1.5),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child:
                                                                PopupMenuButton<
                                                                    int>(
                                                              icon: Icon(
                                                                Icons
                                                                    .more_vert_outlined,
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                              elevation: 0.0,
                                                              splashRadius: 1.0,
                                                              position:
                                                                  PopupMenuPosition
                                                                      .under,
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem<
                                                                    int>(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              kPrimaryColor),
                                                                      SizedBox(
                                                                          width:
                                                                              8),
                                                                      Text(
                                                                          "Update")
                                                                    ],
                                                                  ),
                                                                  value: 0,
                                                                ),
                                                                PopupMenuItem<
                                                                    int>(
                                                                  child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .delete,
                                                                            color:
                                                                                kPrimaryColor),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                            "Delete")
                                                                      ]),
                                                                  value: 1,
                                                                ),
                                                              ],
                                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            child = Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 190,
                                height: 190,
                                child: Image.asset(
                                    "../../../../../assets/images/98560-empty.gif"),
                              ),
                            );
                          }
                          return child;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trip",
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  InkWell(
                    onTap:() {
                      widget.seeMore(2);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "See More",
                            style: TextStyle(color: kPrimaryColor, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.double_arrow_rounded, color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 295,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("Trip"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("Start-DateTime"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("End-DateTime"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("Location"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("Reminder"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Progress"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("File"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Note"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Updated"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Divider(color: kPrimaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Consumer<ActionProvider>(
                            builder: (__, notifier, child) {
                          if (notifier.state == NotifierState.loading) {
                            child = Center(
                              child: Container(
                                child: SpinKitRotatingCircle(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ),
                              ),
                            );
                          } else if (notifier.shortData != null &&
                              notifier.shortData!.data1!.isNotEmpty &&
                              notifier.state == NotifierState.loaded) {
                            child = Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: (notifier.shortData!.data1!.length > 5) ? 5 : notifier.shortData!.data1!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ActionModel _actiontrip =
                                      notifier.shortData!.data1![index];
                                  return InkWell(
                                    // onTap: () {
                                    //   setState(() {
                                    //     widget.callback1!(
                                    //         notifier.tripData!.data![index]);
                                    //   });
                                    // },
                                    child: Container(
                                      // 
                                      child: Row(
                                        children: [
                                          Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        child: Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      kPrimaryColor),
                                                          value: _actiontrip.mark,
                                                          shape: CircleBorder(),
                                                          onChanged: (bool?
                                                              value) async {
                                                            // String tripId =
                                                            //     widget
                                                            //         .trip.sId!;
                                                            // String actionId =
                                                            //     _actiontrip.sId!;
                                                            // bool mark = value!;
                                                            // var response =
                                                            //     await markAction(
                                                            //         tripId,
                                                            //         actionId,
                                                            //         mark);
                                                            // if (response !=
                                                            //     null) {
                                                            //   Provider.of<ActionProvider>(
                                                            //           context,
                                                            //           listen:
                                                            //               false)
                                                            //       .createUpdate(
                                                            //           response);
                                                            // }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_actiontrip.title!
                                                                      .length >=
                                                                  13)
                                                              ? (_actiontrip.title!
                                                                      .substring(
                                                                          0,
                                                                          12) +
                                                                  "...")
                                                              : (_actiontrip
                                                                  .title!),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_actiontrip.startDate !=
                                                                      null &&
                                                                  _actiontrip
                                                                      .startDate!
                                                                      .isNotEmpty)
                                                              ? (_actiontrip
                                                                  .startDate!)
                                                              : ("N/A"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_actiontrip.endDate !=
                                                                      null &&
                                                                  _actiontrip
                                                                      .endDate!
                                                                      .isNotEmpty)
                                                              ? (_actiontrip
                                                                  .endDate!)
                                                              : ("N/A"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_actiontrip.location != null &&
                                                                  _actiontrip
                                                                      .location!
                                                                      .isNotEmpty)
                                                              ? ((_actiontrip.location!
                                                                          .length >=
                                                                      15)
                                                                  ? (_actiontrip
                                                                          .location!
                                                                          .substring(
                                                                              0,
                                                                              15) +
                                                                      "...")
                                                                  : (_actiontrip
                                                                      .location!))
                                                              : ("N/A"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        padding: EdgeInsets.only(right: 50),
                                                        child: FlutterSwitch(
                                                            activeColor:
                                                                kPrimaryColor,
                                                            padding: 0,
                                                            width: 55.0,
                                                            height: 25.0,
                                                            valueFontSize: 12.0,
                                                            // toggleSize: 18.0,
                                                            value:
                                                                _actiontrip.reminder!,
                                                            onToggle: (bool?
                                                                val) async {
                                                              // String tripId =
                                                              //     widget
                                                              //         .trip.sId!;
                                                              // String actionId =
                                                              //     _actiontrip.sId!;
                                                              // bool reminder =
                                                              //     val!;
                                                              // var response =
                                                              //     await actionReminder(
                                                              //         tripId,
                                                              //         actionId,
                                                              //         reminder);
                                                              // if (response !=
                                                              //     null) {
                                                              //   Provider.of<ActionProvider>(
                                                              //           context,
                                                              //           listen:
                                                              //               false)
                                                              //       .createUpdate(
                                                              //           response);
                                                              // }
                                                              // ;
                                                            },
                                                        
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: Text(
                                                            "${_actiontrip.progress}%"),
                                                      ),
                                                    ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                            flex: 6,
                                                            child: Container(
                                                              child:
                                                                  Text("N/A"),
                                                            ),
                                                          ),
                                                        
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              child: Text(
                                                                (_actiontrip.note!
                                                                            .length >=
                                                                        15)
                                                                    ? (_actiontrip.note!.substring(
                                                                            0,
                                                                            15) +
                                                                        "...")
                                                                    : (_actiontrip
                                                                        .note!),
                                                              ),
                                                            ),
                                                          ),
                                                    SizedBox(width: 1.5),
                                                     Expanded(
                                                            flex: 4,
                                                            child: Container(
                                                              child: (_actiontrip.updatedDate !=
                                                                          null &&
                                                                      _actiontrip
                                                                          .updatedDate!
                                                                          .isNotEmpty)
                                                                  ? Text(_actiontrip
                                                                      .updatedDate!)
                                                                  : Text("N/A"),
                                                            ),
                                                          ),
                                                    SizedBox(width: 1.5),
                                                    Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              child:
                                                                  PopupMenuButton<
                                                                      int>(
                                                                icon: Icon(
                                                                  Icons
                                                                      .more_vert_outlined,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                                elevation: 0.0,
                                                                splashRadius:
                                                                    1.0,
                                                                position:
                                                                    PopupMenuPosition
                                                                        .under,
                                                                itemBuilder:
                                                                    (context) =>
                                                                        [
                                                                  PopupMenuItem<
                                                                      int>(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .edit,
                                                                            color:
                                                                                kPrimaryColor),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                            "Update")
                                                                      ],
                                                                    ),
                                                                    value: 0,
                                                                  ),
                                                                  PopupMenuItem<
                                                                      int>(
                                                                    child: Row(
                                                                        children: [
                                                                          Icon(
                                                                              Icons.delete,
                                                                              color: kPrimaryColor),
                                                                          SizedBox(
                                                                              width: 8),
                                                                          Text(
                                                                              "Delete")
                                                                        ]),
                                                                    value: 1,
                                                                  ),
                                                                ],
                                                                onSelected:
                                                                    (value) {
                                                                  // switch (
                                                                  //     value) {
                                                                  //   case 0:
                                                                  //     setState(
                                                                  //         () {
                                                                  //       _d = 3;
                                                                  //       _actiontripCallback = notifier
                                                                  //           .actionData!
                                                                  //           .data![index];
                                                                  //       _scaffoldKey
                                                                  //           .currentState
                                                                  //           ?.openEndDrawer();
                                                                  //     });
                                                                  //     break;
                                                                  //   case 1:
                                                                  //     Alert(
                                                                  //       context:
                                                                  //           context,
                                                                  //       type: AlertType
                                                                  //           .warning,
                                                                  //       title:
                                                                  //           "Comfirmation",
                                                                  //       desc:
                                                                  //           "Are you sure you want to delete this trip?",
                                                                  //       buttons: [
                                                                  //         DialogButton(
                                                                  //           child:
                                                                  //               Text(
                                                                  //             "No",
                                                                  //             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                  //           ),
                                                                  //           onPressed: () =>
                                                                  //               Navigator.pop(context),
                                                                  //           color:
                                                                  //               Colors.red,
                                                                  //         ),
                                                                  //         DialogButton(
                                                                  //           child:
                                                                  //               Text(
                                                                  //             "Yes",
                                                                  //             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                  //           ),
                                                                  //           onPressed:
                                                                  //               () async {
                                                                  //             String tripId = widget.trip.sId!;
                                                                  //             String actionId = _actiontrip.sId!;
                                                                  //             var response = await deleteAction(tripId, actionId);
                                                                  //             if (response == 200) {
                                                                  //               setState(() {
                                                                  //                 notifier.actionData!.data!.removeAt(index);
                                                                  //               });
                                                                  //               Get.snackbar(
                                                                  //                 "Successed",
                                                                  //                 "This trip action has been deleted.",
                                                                  //                 colorText: Colors.white,
                                                                  //                 snackPosition: SnackPosition.TOP,
                                                                  //                 margin: EdgeInsets.only(left: 1230),
                                                                  //                 maxWidth: 300,
                                                                  //                 backgroundColor: Colors.green,
                                                                  //                 duration: Duration(seconds: 3),
                                                                  //                 overlayColor: kPrimaryColor,
                                                                  //               );
                                                                  //               Navigator.pop(context);
                                                                  //               print("Done");
                                                                  //             }
                                                                  //           },
                                                                  //           color:
                                                                  //               Colors.green,
                                                                  //         )
                                                                  //       ],
                                                                  //     ).show();
                                                                  //     break;
                                                                  // }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            child = Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 190,
                                height: 190,
                                child: Image.asset(
                                    "../../../../../assets/images/98560-empty.gif"),
                              ),
                            );
                          }
                          return child;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Meeting",
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  InkWell(
                    onTap:() {
                      widget.seeMore(3);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "See More",
                            style: TextStyle(color: kPrimaryColor, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.double_arrow_rounded, color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 295,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Planning"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Start-Date"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("End-Date"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text("Assign"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("End-Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Location"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Reminder"),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Progress"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("File"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Note"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Updated"),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
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
                        child: Consumer<ActionMeetingProvider>(
                            builder: (__, notifier, child) {
                          if (notifier.state == NotifierState.loading) {
                            child = Center(
                              child: Container(
                                child: SpinKitRotatingCircle(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ),
                              ),
                            );
                          } else if (notifier.shortData != null &&
                              notifier.shortData!.data1!.isNotEmpty &&
                              notifier.state == NotifierState.loaded) {
                            child = Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: (notifier.shortData!.data1!.length > 5) ? 5 : notifier.shortData!.data1!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ActionMeetingModel _actionMeeting =
                                      notifier.shortData!.data1![index];
                                  return InkWell(
                                    // onTap: () {
                                    //   setState(() {
                                    //     widget.callback1!(
                                    //         notifier.tripData!.data![index]);
                                    //   });
                                    // },
                                    child: Container(
                                       
                                      child: Row(
                                        children: [
                                          Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),
                                                        value: _actionMeeting.mark,
                                                        shape: CircleBorder(),
                                                        onChanged: (bool?
                                                            value) async {
                                                        //   String planningId =
                                                        //       widget._actionMeeting
                                                        //           .sId!;
                                                        //   String actionId =
                                                        //       _actionMeeting.sId!;
                                                        //   bool mark = value!;
                                                        //   var response =
                                                        //       await markActionPlanning(
                                                        //           planningId,
                                                        //           actionId,
                                                        //           mark);
                                                        //   if (response !=
                                                        //       null) {
                                                        //     Provider.of<ActionPlanningProvider>(
                                                        //             context,
                                                        //             listen:
                                                        //                 false)
                                                        //         .createUpdate(
                                                        //             response);
                                                        //   }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionMeeting.title!
                                                                    .length >=
                                                                13)
                                                            ? (_actionMeeting.title!
                                                                    .substring(
                                                                        0, 10) +
                                                                "...")
                                                            : (_actionMeeting.title!),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionMeeting.startDate !=
                                                                    null &&
                                                                _actionMeeting
                                                                    .startDate!
                                                                    .isNotEmpty)
                                                            ? (_actionMeeting
                                                                .startDate!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionMeeting.endDate !=
                                                                    null &&
                                                                _actionMeeting.endDate!
                                                                    .isNotEmpty)
                                                            ? (_actionMeeting.endDate!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      child: Text(
                                                        ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        (_actionMeeting.repeat !=
                                                                    null &&
                                                                _actionMeeting.repeat!
                                                                    .isNotEmpty)
                                                            ? (_actionMeeting.repeat!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        (_actionMeeting.endRepeat !=
                                                                    null &&
                                                                _actionMeeting
                                                                    .endRepeat!
                                                                    .isNotEmpty)
                                                            ? (_actionMeeting
                                                                .endRepeat!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionMeeting.location !=
                                                                    null &&
                                                                _actionMeeting
                                                                    .location!
                                                                    .isNotEmpty)
                                                            ? ((_actionMeeting.location!
                                                                        .length >=
                                                                    13)
                                                                ? (_actionMeeting
                                                                        .location!
                                                                        .substring(
                                                                            0,
                                                                            10) +
                                                                    "...")
                                                                : (_actionMeeting
                                                                    .location!))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      child: FlutterSwitch(
                                                        activeColor:
                                                            kPrimaryColor,
                                                        padding: 0,
                                                        width: 55.0,
                                                        height: 25.0,
                                                        valueFontSize: 12.0,
                                                        // toggleSize: 18.0,
                                                        value:
                                                            _actionMeeting.reminder!,
                                                        onToggle:
                                                            (bool? val) async {
                                                          // String planningId =
                                                          //     widget.planning
                                                          //         .sId!;
                                                          // String actionId =
                                                          //     _actionMeeting.sId!;
                                                          // bool reminder = val!;
                                                          // print(reminder);
                                                          // var response =
                                                          //     await planningActionReminder(
                                                          //         planningId,
                                                          //         actionId,
                                                          //         reminder);
                                                          // if (response !=
                                                          //     null) {
                                                          //   Provider.of<ActionPlanningProvider>(
                                                          //           context,
                                                          //           listen:
                                                          //               false)
                                                          //       .createUpdate(
                                                          //           response);
                                                          // }
                                                          // ;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            child: Text(
                                                                "${_actionMeeting.progress}%"),
                                                          ),
                                                        ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            child: Text("N/A"),
                                                          ),
                                                        ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            child: Text(
                                                              (_actionMeeting.note!
                                                                          .length >=
                                                                      13)
                                                                  ? (_actionMeeting
                                                                          .note!
                                                                          .substring(
                                                                              0,
                                                                              10) +
                                                                      "...")
                                                                  : (_actionMeeting
                                                                      .note!),
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            child: Text((_actionMeeting
                                                                            .updatedDate !=
                                                                        null &&
                                                                    _actionMeeting.updatedDate!
                                                                        .isNotEmpty)
                                                                ? ((_actionMeeting.updatedDate!
                                                                            .length >
                                                                        7)
                                                                    ? (_actionMeeting
                                                                        .updatedDate!
                                                                        .substring(
                                                                            0,
                                                                            7))
                                                                    : (_actionMeeting
                                                                        .updatedDate!))
                                                                : ("N/A")),
                                                          ),
                                                        ),
                                                  Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            child:
                                                                PopupMenuButton<
                                                                    int>(
                                                              icon: Icon(
                                                                Icons
                                                                    .more_vert_outlined,
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                              elevation: 0.0,
                                                              splashRadius: 1.0,
                                                              position:
                                                                  PopupMenuPosition
                                                                      .under,
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem<
                                                                    int>(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              kPrimaryColor),
                                                                      SizedBox(
                                                                          width:
                                                                              8),
                                                                      Text(
                                                                          "Update")
                                                                    ],
                                                                  ),
                                                                  value: 0,
                                                                ),
                                                                PopupMenuItem<
                                                                    int>(
                                                                  child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .delete,
                                                                            color:
                                                                                kPrimaryColor),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                            "Delete")
                                                                      ]),
                                                                  value: 1,
                                                                ),
                                                              ],
                                                              onSelected:
                                                                  (value) {
                                                                // switch (value) {
                                                                //   case 0:
                                                                //     setState(
                                                                //         () {
                                                                //       _d = 3;
                                                                //       _actionCallback2 = notifier
                                                                //           .actionData!
                                                                //           .data![index];
                                                                //       _scaffoldKey
                                                                //           .currentState
                                                                //           ?.openEndDrawer();
                                                                //     });
                                                                //     break;
                                                                //   case 1:
                                                                //     Alert(
                                                                //       context:
                                                                //           context,
                                                                //       type: AlertType
                                                                //           .warning,
                                                                //       title:
                                                                //           "Comfirmation",
                                                                //       desc:
                                                                //           "Are you sure you want to delete this action?",
                                                                //       buttons: [
                                                                //         DialogButton(
                                                                //           child:
                                                                //               Text(
                                                                //             "No",
                                                                //             style: TextStyle(
                                                                //                 color: Colors.white,
                                                                //                 fontSize: 20,
                                                                //                 fontFamily: "Family Name"),
                                                                //           ),
                                                                //           onPressed: () =>
                                                                //               Navigator.pop(context),
                                                                //           color:
                                                                //               Colors.red,
                                                                //         ),
                                                                //         DialogButton(
                                                                //           child:
                                                                //               Text(
                                                                //             "Yes",
                                                                //             style: TextStyle(
                                                                //                 color: Colors.white,
                                                                //                 fontSize: 20,
                                                                //                 fontFamily: "Family Name"),
                                                                //           ),
                                                                //           onPressed:
                                                                //               () async {
                                                                //             String
                                                                //                 planningId =
                                                                //                 widget.planning.sId!;
                                                                //             String
                                                                //                 actionId =
                                                                //                 _actionMeeting.sId!;
                                                                //             var response =
                                                                //                 await deleteActionPlanning(planningId, actionId);
                                                                //             if (response ==
                                                                //                 200) {
                                                                //               setState(() {
                                                                //                 notifier.actionData!.data!.removeAt(index);
                                                                //               });
                                                                //               Get.snackbar(
                                                                //                 "Successed",
                                                                //                 "This trip action has been deleted.",
                                                                //                 colorText: Colors.white,
                                                                //                 snackPosition: SnackPosition.TOP,
                                                                //                 margin: EdgeInsets.only(left: 1230),
                                                                //                 maxWidth: 300,
                                                                //                 backgroundColor: Colors.green,
                                                                //                 duration: Duration(seconds: 3),
                                                                //                 overlayColor: kPrimaryColor,
                                                                //               );
                                                                //               Navigator.pop(context);
                                                                //               print("Done");
                                                                //             }
                                                                //           },
                                                                //           color:
                                                                //               Colors.green,
                                                                //         )
                                                                //       ],
                                                                //     ).show();
                                                                //     break;
                                                                // }
                                                              },
                                                            ),
                                                          ),
                                                        )
                                                      ,
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            child = Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 190,
                                height: 190,
                                child: Image.asset(
                                    "../../../../../assets/images/98560-empty.gif"),
                              ),
                            );
                          }
                          return child;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Planning",
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  InkWell(
                    onTap:() {
                      widget.seeMore(4);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "See More",
                            style: TextStyle(color: kPrimaryColor, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.double_arrow_rounded, color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 295,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Planning"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Start-Date"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("End-Date"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text("Assign"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text("End-Repeat"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text("Location"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Reminder"),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Progress"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("File"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text("Note"),
                            ),
                          ),
                          SizedBox(width: 1.5),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text("Updated"),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(""),
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
                        child: Consumer<ActionPlanningProvider>(
                            builder: (__, notifier, child) {
                          if (notifier.state == NotifierState.loading) {
                            child = Center(
                              child: Container(
                                child: SpinKitRotatingCircle(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ),
                              ),
                            );
                          } else if (notifier.shortData != null &&
                              notifier.shortData!.data1!.isNotEmpty &&
                              notifier.state == NotifierState.loaded) {
                            child = Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: (notifier.shortData!.data1!.length > 5) ? 5 : notifier.shortData!.data1!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ActionPlanningModel _actionPlanning =
                                      notifier.shortData!.data1![index];
                                  return InkWell(
                                    // onTap: () {
                                    //   setState(() {
                                    //     widget.callback1!(
                                    //         notifier.tripData!.data![index]);
                                    //   });
                                    // },
                                    child: Container(
                                      
                                      child: Row(
                                        children: [
                                          Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),
                                                        value: _actionPlanning.mark,
                                                        shape: CircleBorder(),
                                                        onChanged: (bool?
                                                            value) async {
                                                          // String planningId =
                                                          //     widget.planning
                                                          //         .sId!;
                                                          // String actionId =
                                                          //     _actionPlanning.sId!;
                                                          // bool mark = value!;
                                                          // var response =
                                                          //     await markActionPlanning(
                                                          //         planningId,
                                                          //         actionId,
                                                          //         mark);
                                                          // if (response !=
                                                          //     null) {
                                                          //   Provider.of<ActionPlanningProvider>(
                                                          //           context,
                                                          //           listen:
                                                          //               false)
                                                          //       .createUpdate(
                                                          //           response);
                                                          // }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionPlanning.title!
                                                                    .length >=
                                                                13)
                                                            ? (_actionPlanning.title!
                                                                    .substring(
                                                                        0, 10) +
                                                                "...")
                                                            : (_actionPlanning.title!),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionPlanning.startDate !=
                                                                    null &&
                                                                _actionPlanning
                                                                    .startDate!
                                                                    .isNotEmpty)
                                                            ? (_actionPlanning
                                                                .startDate!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionPlanning.endDate !=
                                                                    null &&
                                                                _actionPlanning.endDate!
                                                                    .isNotEmpty)
                                                            ? (_actionPlanning.endDate!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      child: Text(
                                                        ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        (_actionPlanning.repeat !=
                                                                    null &&
                                                                _actionPlanning.repeat!
                                                                    .isNotEmpty)
                                                            ? (_actionPlanning.repeat!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        (_actionPlanning.endRepeat !=
                                                                    null &&
                                                                _actionPlanning
                                                                    .endRepeat!
                                                                    .isNotEmpty)
                                                            ? (_actionPlanning
                                                                .endRepeat!
                                                                .substring(
                                                                    0, 7))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      child: Text(
                                                        (_actionPlanning.location !=
                                                                    null &&
                                                                _actionPlanning
                                                                    .location!
                                                                    .isNotEmpty)
                                                            ? ((_actionPlanning.location!
                                                                        .length >=
                                                                    13)
                                                                ? (_actionPlanning
                                                                        .location!
                                                                        .substring(
                                                                            0,
                                                                            10) +
                                                                    "...")
                                                                : (_actionPlanning
                                                                    .location!))
                                                            : ("N/A"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      child: FlutterSwitch(
                                                        activeColor:
                                                            kPrimaryColor,
                                                        padding: 0,
                                                        width: 55.0,
                                                        height: 25.0,
                                                        valueFontSize: 12.0,
                                                        // toggleSize: 18.0,
                                                        value:
                                                            _actionPlanning.reminder!,
                                                        onToggle:
                                                            (bool? val) async {
                                                          // String planningId =
                                                          //     widget.planning
                                                          //         .sId!;
                                                          // String actionId =
                                                          //     _action.sId!;
                                                          // bool reminder = val!;
                                                          // print(reminder);
                                                          // var response =
                                                          //     await planningActionReminder(
                                                          //         planningId,
                                                          //         actionId,
                                                          //         reminder);
                                                          // if (response !=
                                                          //     null) {
                                                          //   Provider.of<ActionPlanningProvider>(
                                                          //           context,
                                                          //           listen:
                                                          //               false)
                                                          //       .createUpdate(
                                                          //           response);
                                                          // }
                                                          // ;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            child: Text(
                                                                "${_actionPlanning.progress}%"),
                                                          ),
                                                        ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            child: Text("N/A"),
                                                          ),
                                                        ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            child: Text(
                                                              (_actionPlanning.note!
                                                                          .length >=
                                                                      13)
                                                                  ? (_actionPlanning
                                                                          .note!
                                                                          .substring(
                                                                              0,
                                                                              10) +
                                                                      "...")
                                                                  : (_actionPlanning
                                                                      .note!),
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 1.5),
                                                  Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            child: Text((_actionPlanning
                                                                            .updatedDate !=
                                                                        null &&
                                                                    _actionPlanning.updatedDate!
                                                                        .isNotEmpty)
                                                                ? ((_actionPlanning.updatedDate!
                                                                            .length >
                                                                        7)
                                                                    ? (_actionPlanning
                                                                        .updatedDate!
                                                                        .substring(
                                                                            0,
                                                                            7))
                                                                    : (_actionPlanning
                                                                        .updatedDate!))
                                                                : ("N/A")),
                                                          ),
                                                        ),
                                                  Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            child:
                                                                PopupMenuButton<
                                                                    int>(
                                                              icon: Icon(
                                                                Icons
                                                                    .more_vert_outlined,
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                              elevation: 0.0,
                                                              splashRadius: 1.0,
                                                              position:
                                                                  PopupMenuPosition
                                                                      .under,
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem<
                                                                    int>(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              kPrimaryColor),
                                                                      SizedBox(
                                                                          width:
                                                                              8),
                                                                      Text(
                                                                          "Update")
                                                                    ],
                                                                  ),
                                                                  value: 0,
                                                                ),
                                                                PopupMenuItem<
                                                                    int>(
                                                                  child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .delete,
                                                                            color:
                                                                                kPrimaryColor),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                            "Delete")
                                                                      ]),
                                                                  value: 1,
                                                                ),
                                                              ],
                                                              onSelected:
                                                                  (value) {
                                                                // switch (value) {
                                                                //   case 0:
                                                                //     setState(
                                                                //         () {
                                                                //       _d = 3;
                                                                //       _actionCallback2 = notifier
                                                                //           .actionData!
                                                                //           .data![index];
                                                                //       _scaffoldKey
                                                                //           .currentState
                                                                //           ?.openEndDrawer();
                                                                //     });
                                                                //     break;
                                                                //   case 1:
                                                                //     Alert(
                                                                //       context:
                                                                //           context,
                                                                //       type: AlertType
                                                                //           .warning,
                                                                //       title:
                                                                //           "Comfirmation",
                                                                //       desc:
                                                                //           "Are you sure you want to delete this action?",
                                                                //       buttons: [
                                                                //         DialogButton(
                                                                //           child:
                                                                //               Text(
                                                                //             "No",
                                                                //             style: TextStyle(
                                                                //                 color: Colors.white,
                                                                //                 fontSize: 20,
                                                                //                 fontFamily: "Family Name"),
                                                                //           ),
                                                                //           onPressed: () =>
                                                                //               Navigator.pop(context),
                                                                //           color:
                                                                //               Colors.red,
                                                                //         ),
                                                                //         DialogButton(
                                                                //           child:
                                                                //               Text(
                                                                //             "Yes",
                                                                //             style: TextStyle(
                                                                //                 color: Colors.white,
                                                                //                 fontSize: 20,
                                                                //                 fontFamily: "Family Name"),
                                                                //           ),
                                                                //           onPressed:
                                                                //               () async {
                                                                //             String
                                                                //                 planningId =
                                                                //                 widget.planning.sId!;
                                                                //             String
                                                                //                 actionId =
                                                                //                 _action.sId!;
                                                                //             var response =
                                                                //                 await deleteActionPlanning(planningId, actionId);
                                                                //             if (response ==
                                                                //                 200) {
                                                                //               setState(() {
                                                                //                 notifier.actionData!.data!.removeAt(index);
                                                                //               });
                                                                //               Get.snackbar(
                                                                //                 "Successed",
                                                                //                 "This trip action has been deleted.",
                                                                //                 colorText: Colors.white,
                                                                //                 snackPosition: SnackPosition.TOP,
                                                                //                 margin: EdgeInsets.only(left: 1230),
                                                                //                 maxWidth: 300,
                                                                //                 backgroundColor: Colors.green,
                                                                //                 duration: Duration(seconds: 3),
                                                                //                 overlayColor: kPrimaryColor,
                                                                //               );
                                                                //               Navigator.pop(context);
                                                                //               print("Done");
                                                                //             }
                                                                //           },
                                                                //           color:
                                                                //               Colors.green,
                                                                //         )
                                                                //       ],
                                                                //     ).show();
                                                                //     break;
                                                                // }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            child = Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 190,
                                height: 190,
                                child: Image.asset(
                                    "../../../../../assets/images/98560-empty.gif"),
                              ),
                            );
                          }
                          return child;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
