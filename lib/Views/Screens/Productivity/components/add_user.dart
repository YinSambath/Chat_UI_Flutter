import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/meeting_model.dart';
import 'package:mcircle_project_ui/Models/planning_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/Providers/contact_provider.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddUser extends StatefulWidget {
  final Function countMember;
  AddUser({Key? key, this.tripData, this.meetingData, this.planningData, required this.countMember}) : super(key: key);
  TripModel? tripData;
  MeetingModel? meetingData;
  PlanningModel? planningData;
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  // bool isTripCheck = false;
  // List<ContactModel>? listTripMember;
  // List<ContactModel>? listMeetingMember;
  // List<ContactModel>? listPlanningMember;
  List<String> addedUser = [];
  int? index;
  List<String> _listTripMember = [];
  List<String> _listMeetingMember = [];
  List<String> _listPlanningMember = [];
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  final GlobalKey<FormState> _formKey = GlobalKey();
   @override
  void initState() {
    (widget.tripData != null)
      ?getListMember()
      :(widget.meetingData != null)
      ? getListMeeetingMember()
      :(widget.planningData != null)
      ?getListPlanningMember()
      :SizedBox();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ContactProvider>(context, listen: false).getContactData();
    });
  }

// get list of member in trip 
void getListMember() async {
  final list = await getListTripUser(widget.tripData!.sId!);
  if (list != null) {
    for (int i=0; i<list.length; i++) {
      _listTripMember.add(list[i].sId);
    }
  }
}

void getListMeeetingMember() async {
  final list = await getListMeetingUser(widget.meetingData!.sId!);
  if (list != null) {
    for (int i=0; i<list.length; i++) {
      _listMeetingMember.add(list[i].sId);
    }
  }
}

void getListPlanningMember() async {
  final list = await getListPlanningUser(widget.planningData!.sId!);
  if (list != null) {
    for (int i=0; i<list.length; i++) {
      _listPlanningMember.add(list[i].sId);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 1200,
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 250, 249, 249),
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: DrawerHeader(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (widget.tripData != null) {
                                      List<String> selectedUser = _listTripMember;
                                      String tripId = widget.tripData!.sId!;
                                      var response = await addUser(selectedUser, tripId);
                                      if (response != null) {
                                        Get.snackbar(
                                            "Successed", "Added to trip!",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor);
                                            setState(() {
                                              widget.countMember(_listTripMember.length); 
                                            });
                                        // Provider.of<TripProvider>(context,
                                        //         listen: false)
                                        //     .createUpdate(response);
                                        
                                      }Navigator.of(context).pop();
                                    } else if (widget.meetingData != null) {
                                        List<String> selectedUser = _listMeetingMember;
                                      String meetingId = widget.meetingData!.sId!;
                                      print(widget.meetingData!.sId!);
                                      var response = await meetingAddUser(selectedUser, meetingId);
                                      if (response != null) {
                                        Get.snackbar(
                                            "Successed", "Added to meeting!",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor);
                                            setState(() {
                                              widget.countMember(_listMeetingMember.length); 
                                            });
                                      }Navigator.of(context).pop();
                                    } else {
                                      List<String> selectedUser = _listPlanningMember;
                                      String planningId = widget.planningData!.sId!;
                                      var response = await planningAddUser(selectedUser, planningId);
                                      if (response != null) {
                                        Get.snackbar(
                                            "Successed", "Added member to planning!.",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor);
                                            setState(() {
                                              widget.countMember(_listPlanningMember.length); 
                                            });
                                      }Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Add User",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        Container(
                    height: 40,
                    width: 300,
                    // constraints: BoxConstraints(maxWidth: 250),
                    child: TextFormField(
                      onChanged: (value) async {
                        String search = value;
                          final response = await searchContact(search);
                          if (response != null) {
                            Provider.of<ContactProvider>(context, listen: false)
                                .getSearchContact(search);
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
                  SizedBox(height: 15),
                  (widget.tripData != null)?Consumer<ContactProvider>(
                                      builder: (__, notifier, child) {
                                    if (notifier.state ==
                                        NotifierState.loading) {
                                      child = const Center(
                                        child: SpinKitRotatingCircle(
                                          color: kPrimaryColor,
                                        ),
                                      );
                                    } else if (notifier.contactData != null && notifier.contactData!.data != null &&
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
                                            ContactModel _contact = notifier.contactData!.data![index];
                                            return InkWell(
                                              onTap: () {
                                                if(_listTripMember.contains(_contact.sId)) {
                                                    _listTripMember.remove(_contact.sId);
                                                } else if (!_listTripMember.contains(_contact.sId)) {
                                                    _listTripMember.add(_contact.sId!);
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 400,
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
                                                          leading: Icon(Icons
                                                              .contact_page_sharp),
                                                          title: Text(
                                                              "${_contact.firstname} ${_contact.lastname}"),
                                                          subtitle: Text(
                                                              "${_contact.phone}"),
                                                          trailing: Checkbox(
                                                            value: (_listTripMember.contains(_contact.sId ))? !_contact.isTripCheck! :_contact.isTripCheck, 
                                                            onChanged: (bool? value) {
                                                              if(_listTripMember.contains(_contact.sId)) {
                                                                _listTripMember.remove(_contact.sId);
                                                              }
                                                              else if (!_listTripMember.contains(_contact.sId)) {
                                                                _listTripMember.add(_contact.sId!);
                                                              }
                                                              setState(() {});
                                                             },
                                                            shape: CircleBorder(),
                                                            checkColor:
                                                            Colors.white,
                                                            fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),),
                                                              
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
                                  }):
                  (widget.meetingData != null)?Consumer<ContactProvider>(
                                      builder: (__, notifier, child) {
                                    if (notifier.state ==
                                        NotifierState.loading) {
                                      child = const Center(
                                        child: SpinKitRotatingCircle(
                                          color: kPrimaryColor,
                                        ),
                                      );
                                    } else if (notifier.contactData != null && notifier.contactData!.data != null &&
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
                                            ContactModel _contact = notifier.contactData!.data![index];
                                            return InkWell(
                                              onTap: () {
                                                if(_listMeetingMember.contains(_contact.sId)) {
                                                    _listMeetingMember.remove(_contact.sId);
                                                } else if (!_listMeetingMember.contains(_contact.sId)) {
                                                    _listMeetingMember.add(_contact.sId!);
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 400,
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
                                                          leading: Icon(Icons
                                                              .contact_page_sharp),
                                                          title: Text(
                                                              "${_contact.firstname} ${_contact.lastname}"),
                                                          subtitle: Text(
                                                              "${_contact.phone}"),
                                                          trailing: Checkbox(
                                                            value: (_listMeetingMember.contains(_contact.sId ))? !_contact.isTripCheck! :_contact.isTripCheck, 
                                                            onChanged: (bool? value) {
                                                              if(_listMeetingMember.contains(_contact.sId)) {
                                                                _listMeetingMember.remove(_contact.sId);
                                                              }
                                                              else if (!_listMeetingMember.contains(_contact.sId)) {
                                                                _listMeetingMember.add(_contact.sId!);
                                                              }
                                                              setState(() {});
                                                             },
                                                            shape: CircleBorder(),
                                                            checkColor:
                                                            Colors.white,
                                                            fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),),
                                                              
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
                                  }):
                  (widget.planningData != null)?Consumer<ContactProvider>(
                                      builder: (__, notifier, child) {
                                    if (notifier.state ==
                                        NotifierState.loading) {
                                      child = const Center(
                                        child: SpinKitRotatingCircle(
                                          color: kPrimaryColor,
                                        ),
                                      );
                                    } else if (notifier.contactData != null && notifier.contactData!.data != null &&
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
                                            ContactModel _contact = notifier.contactData!.data![index];
                                            return InkWell(
                                              onTap: () {
                                                if(_listPlanningMember.contains(_contact.sId)) {
                                                    _listPlanningMember.remove(_contact.sId);
                                                } else if (!_listPlanningMember.contains(_contact.sId)) {
                                                    _listPlanningMember.add(_contact.sId!);
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 400,
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
                                                          leading: Icon(Icons
                                                              .contact_page_sharp),
                                                          title: Text(
                                                              "${_contact.firstname} ${_contact.lastname}"),
                                                          subtitle: Text(
                                                              "${_contact.phone}"),
                                                          trailing: Checkbox(
                                                            value: (_listPlanningMember.contains(_contact.sId ))? !_contact.isTripCheck! :_contact.isTripCheck, 
                                                            onChanged: (bool? value) {
                                                              if(_listPlanningMember.contains(_contact.sId)) {
                                                                _listPlanningMember.remove(_contact.sId);
                                                              }
                                                              else if (!_listPlanningMember.contains(_contact.sId)) {
                                                                _listPlanningMember.add(_contact.sId!);
                                                              }
                                                              setState(() {});
                                                             },
                                                            shape: CircleBorder(),
                                                            checkColor:
                                                            Colors.white,
                                                            fillColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kPrimaryColor),),
                                                              
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
                                  }):SizedBox(),
                        
                      ],
                    ),
            
          
                  ], 
                  ),
                  ),
                  ),
                  ),
                  ),
     
    );
  }
  
}

