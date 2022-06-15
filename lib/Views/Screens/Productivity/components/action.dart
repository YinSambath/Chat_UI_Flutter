import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/add_user.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/update_action.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/update_trip.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/action_model.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/Providers/action_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_folders.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/create_trips_actios.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class ActionList extends StatefulWidget {
  final Function widget1;
  TripModel trip;
  ActionList({
    Key? key,
    required this.widget1,
    required this.trip,
  }) : super(key: key);
  @override
  State<ActionList> createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  int _d = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _info = false;
  bool checkbox = false;
  ActionModel? _actionCallback;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ActionProvider>(context, listen: false)
          .getActionData(widget.trip.sId!);
    });
  }

  callbackMember(int value) {
    setState(() {
      widget.trip.member = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1095,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: (_d == 1)
            ? CreateTripAction(tripData: widget.trip)
            : (_d == 2)
                ? UpdateTrip(
                    tripData: widget.trip,
                    onUpdated: (TripModel tripCallBack) {
                      setState(() {
                        widget.trip = tripCallBack;
                      });
                    },
                  )
                : (_d == 3)
                    ? UpdateAction(
                        tripData: widget.trip, actionData: _actionCallback)
                    :(_d == 4) ? AddUser(tripData: widget.trip, countMember: callbackMember): SizedBox(),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Color.fromARGB(255, 250, 249, 249),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Container(
                  width: 1095,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 245,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11)),
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_back_ios,
                                              color: kPrimaryColor),
                                          SizedBox(width: 3),
                                          Text(
                                            "List",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        widget.widget1(4);
                                      });
                                      // Navigator.of(context).pop();
                                    }),
                                Column(
                                  children: [
                                    Text(
                                      "${widget.trip.title}",
                                      style: TextStyle(color: kPrimaryColor),
                                    ), 
                                    Text(
                                      "Member: ${widget.trip.member}",
                                      style: TextStyle(color: Colors.grey, fontSize: 10),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _info = !_info;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black54,
                                      ),
                                      icon: Icon(Icons.info_outline_rounded),
                                      label: Text("Info"),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _d = 1;
                                        });
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      child: Text("New Action Trip"),
                                      style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 12, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Title: " + widget.trip.title!),
                                        SizedBox(height: 3),
                                        Text(
                                          ((widget.trip.startDate != null &&
                                                      widget.trip.startDate!
                                                          .isNotEmpty)
                                                  ? (widget.trip.startDate!)
                                                  : ("N/A")) +
                                              " - " +
                                              ((widget.trip.endDate != null &&
                                                      widget.trip.startDate!
                                                          .isNotEmpty)
                                                  ? (widget.trip.startDate!)
                                                  : ("N/A")),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Note: " + widget.trip.note!,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 25,
                                          width: 150,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                          child: Text(widget.trip.location!),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              width: 250,
                              child: TextFormField(
                                onChanged: (value) async {
                                  String search = value;
                                  String tripId = widget.trip.sId!;
                                  final response =
                                      await searchAction(search, tripId);
                                  if (response != null) {
                                    Provider.of<ActionProvider>(context,
                                            listen: false)
                                        .getSearchAction(search, tripId);
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
                                  hintText: "Search",
                                  suffixIcon:
                                      Icon(Icons.search, color: kPrimaryColor),
                                  filled: true,
                                ),
                              ),
                              // color: Colors.pink,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1095,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, right: 16, left: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(""),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text("Task"),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Text("Assign")
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
                                  (_info == false)
                                      ? Expanded(
                                          flex: 5,
                                          child: Container(
                                            child: Text("File"),
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(width: 2),
                                  (_info == false)
                                      ? Expanded(
                                          flex: 6,
                                          child: Container(
                                            child: Text("Note"),
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(width: 2),
                                  (_info == false)
                                      ? Expanded(
                                          flex: 5,
                                          child: Container(
                                            child: Text("Updated"),
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(width: 2),
                                  (_info == false)
                                      ? Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Text(""),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Divider(color: kPrimaryColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Consumer<ActionProvider>(
                                    builder: (__, notifier, child) {
                                  if (notifier.state == NotifierState.loading) {
                                    child = const Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    );
                                  } else if (notifier.actionData != null &&
                                      notifier.actionData!.data!.isNotEmpty &&
                                      notifier.state == NotifierState.loaded) {
                                    child = SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              notifier.actionData!.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            ActionModel _action = notifier
                                                .actionData!.data![index];
                                            return InkWell(
                                              onTap: () {},
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 12),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        child: Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      kPrimaryColor),
                                                          value: _action.mark,
                                                          shape: CircleBorder(),
                                                          onChanged: (bool?
                                                              value) async {
                                                            String tripId =
                                                                widget
                                                                    .trip.sId!;
                                                            String actionId =
                                                                _action.sId!;
                                                            bool mark = value!;
                                                            var response =
                                                                await markAction(
                                                                    tripId,
                                                                    actionId,
                                                                    mark);
                                                            if (response !=
                                                                null) {
                                                              Provider.of<ActionProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .createUpdate(
                                                                      response);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_action.title!
                                                                      .length >=
                                                                  13)
                                                              ? (_action.title!
                                                                      .substring(
                                                                          0,
                                                                          12) +
                                                                  "...")
                                                              : (_action
                                                                  .title!),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 3),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        child: Text((_action.assignTo != null)
                                                                      ?(_action.assignTo.firstname.length > 3 )
                                                                        ?(_action.assignTo.firstname.sunstring(0,3))
                                                                          :(_action.assignTo.firstname)
                                                                      :("N/A")
                                                                    ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_action.startDate !=
                                                                      null &&
                                                                  _action
                                                                      .startDate!
                                                                      .isNotEmpty)
                                                              ? (_action
                                                                  .startDate!)
                                                              : ("N/A"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_action.endDate !=
                                                                      null &&
                                                                  _action
                                                                      .endDate!
                                                                      .isNotEmpty)
                                                              ? (_action
                                                                  .endDate!)
                                                              : ("N/A"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        child: Text(
                                                          (_action.location != null &&
                                                                  _action
                                                                      .location!
                                                                      .isNotEmpty)
                                                              ? ((_action.location!
                                                                          .length >=
                                                                      15)
                                                                  ? (_action
                                                                          .location!
                                                                          .substring(
                                                                              0,
                                                                              15) +
                                                                      "...")
                                                                  : (_action
                                                                      .location!))
                                                              : ("N/A"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Expanded(
                                                      flex: 6,
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
                                                              _action.reminder!,
                                                          onToggle: (bool?
                                                              val) async {
                                                            String tripId =
                                                                widget
                                                                    .trip.sId!;
                                                            String actionId =
                                                                _action.sId!;
                                                            bool reminder =
                                                                val!;
                                                            var response =
                                                                await actionReminder(
                                                                    tripId,
                                                                    actionId,
                                                                    reminder);
                                                            if (response !=
                                                                null) {
                                                              Provider.of<ActionProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
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
                                                            "${_action.progress}%"),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    (_info == false)
                                                        ? Expanded(
                                                            flex: 6,
                                                            child: Container(
                                                              child:
                                                                  Text("N/A"),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(width: 2),
                                                    (_info == false)
                                                        ? Expanded(
                                                            flex: 7,
                                                            child: Container(
                                                              child: Text(
                                                                (_action.note!
                                                                            .length >=
                                                                        15)
                                                                    ? (_action.note!.substring(
                                                                            0,
                                                                            15) +
                                                                        "...")
                                                                    : (_action
                                                                        .note!),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(width: 2),
                                                    (_info == false)
                                                        ? Expanded(
                                                            flex: 5,
                                                            child: Container(
                                                              child: (_action.updatedDate !=
                                                                          null ||
                                                                      _action
                                                                          .updatedDate!
                                                                          .isNotEmpty)
                                                                  ? Text(_action
                                                                      .updatedDate!)
                                                                  : Text("N/A"),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(width: 2),
                                                    (_info == false)
                                                        ? Expanded(
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
                                                                  switch (
                                                                      value) {
                                                                    case 0:
                                                                      setState(
                                                                          () {
                                                                        _d = 3;
                                                                        _actionCallback = notifier
                                                                            .actionData!
                                                                            .data![index];
                                                                            print(notifier
                                                                            .actionData!
                                                                            .data![index].sId);
                                                                        _scaffoldKey
                                                                            .currentState
                                                                            ?.openEndDrawer();
                                                                      });
                                                                      break;
                                                                    case 1:
                                                                      Alert(
                                                                        context:
                                                                            context,
                                                                        type: AlertType
                                                                            .warning,
                                                                        title:
                                                                            "Comfirmation",
                                                                        desc:
                                                                            "Are you sure you want to delete this trip?",
                                                                        buttons: [
                                                                          DialogButton(
                                                                            child:
                                                                                Text(
                                                                              "No",
                                                                              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                            ),
                                                                            onPressed: () =>
                                                                                Navigator.pop(context),
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                          DialogButton(
                                                                            child:
                                                                                Text(
                                                                              "Yes",
                                                                              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Family Name"),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              String tripId = widget.trip.sId!;
                                                                              String actionId = _action.sId!;
                                                                              var response = await deleteAction(tripId, actionId);
                                                                              if (response == 200) {
                                                                                setState(() {
                                                                                  notifier.actionData!.data!.removeAt(index);
                                                                                });
                                                                                Get.snackbar(
                                                                                  "Successed",
                                                                                  "This trip action has been deleted.",
                                                                                  colorText: Colors.white,
                                                                                  snackPosition: SnackPosition.TOP,
                                                                                  margin: EdgeInsets.only(left: 1230),
                                                                                  maxWidth: 300,
                                                                                  backgroundColor: Colors.green,
                                                                                  duration: Duration(seconds: 3),
                                                                                  overlayColor: kPrimaryColor,
                                                                                );
                                                                                Navigator.pop(context);
                                                                                print("Done");
                                                                              }
                                                                            },
                                                                            color:
                                                                                Colors.green,
                                                                          )
                                                                        ],
                                                                      ).show();
                                                                      break;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  } else {
                                    child = const Center(
                                      child: Text("No data"),
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
            ),
            SizedBox(width: 15),
            (_info == true)
                ? Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 400,
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text(
                                widget.trip.title!,
                                style: TextStyle(
                                  fontFamily: "Family Name",
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Member: ",
                                style: TextStyle(
                                  fontFamily: "Family Name",
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 80,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(!mounted) {
                                    print("Secttion");
                                    return;
                                  }
                                  setState(() {
                                    _d = 4;
                                  });
                                   _scaffoldKey.currentState?.openEndDrawer();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person_add,
                                        color: kPrimaryColor),
                                    SizedBox(height: 1),
                                    Text("  Add  ",
                                        style: TextStyle(color: kPrimaryColor)),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 80,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _d = 2;
                                  });
                                  _scaffoldKey.currentState?.openEndDrawer();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit, color: kPrimaryColor),
                                    SizedBox(height: 1),
                                    Text(
                                      "Update",
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 80,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Comfirmation",
                                    desc:
                                        "Are you sure you want to delete this folder?",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: "Family Name"),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.red,
                                      ),
                                      DialogButton(
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: "Family Name"),
                                        ),
                                        onPressed: () async {
                                          String tripId = widget.trip.sId!;
                                          var response =
                                              await deleteTrip(tripId);
                                          if (response == 200) {
                                            setState(() {
                                              widget.widget1(4);
                                            });
                                            Get.snackbar("Successed",
                                                "Trip has been deleted.",
                                                colorText: Colors.white,
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                margin:
                                                    EdgeInsets.only(left: 1230),
                                                maxWidth: 300,
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 3),
                                                overlayColor: kPrimaryColor);
                                            Navigator.pop(context);
                                            
                                          }
                                        },
                                        color: Colors.green,
                                      )
                                    ],
                                  ).show();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(height: 1),
                                    Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(),
                        ChatInfoPrivate(),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
