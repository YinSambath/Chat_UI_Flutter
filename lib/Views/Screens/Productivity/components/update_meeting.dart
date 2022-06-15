import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:mcircle_project_ui/Models/meeting_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/Providers/action_provider.dart';
import 'package:mcircle_project_ui/Providers/meeting_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/widgets/google_map.dart';
import 'package:mcircle_project_ui/chat_app.dart';

// ignore: must_be_immutable
class UpdateMeeting extends StatefulWidget {
  final Function(MeetingModel meetingCallBack) onUpdated;
  MeetingModel? meetingData;
  UpdateMeeting({
    Key? key,
    required this.onUpdated,
    this.meetingData,
  }) : super(key: key);
  @override
  State<UpdateMeeting> createState() => _UpdateMeetingState();
}

class _UpdateMeetingState extends State<UpdateMeeting> {
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController _location = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _valueMeeting;
  bool _reminder = false;
  double _progress = 0;
  var selectedDate;
  var selectedEndDate;
  var endRepeatDate;
  String? _seletedDate;
  String? _seletedEndDate;
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1955),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        _seletedDate = dateFormat.format(selectedDate);
        _startDate.text = _seletedDate!;
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? endDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (endDate != null && endDate != selectedEndDate) {
      setState(() {
        selectedEndDate = endDate;
        _seletedEndDate = dateFormat.format(selectedEndDate);
        _endDate.text = _seletedEndDate!;
      });
    }
  }

  @override
  void initState() {
    if (widget.meetingData != null) {
      _valueMeeting = widget.meetingData!.sId!;
      _title.text = widget.meetingData!.title!;
      _note.text = widget.meetingData!.note!;
      _startDate.text = widget.meetingData!.startDate!;
      _endDate.text = widget.meetingData!.endDate!;
      _location.text = widget.meetingData!.location!;
      _reminder = widget.meetingData!.reminder!;
      _progress = widget.meetingData!.progress!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        width: 400,
        height: (widget.meetingData != null) ? 1200 : 1024,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 1, color: Colors.grey.shade200),
          ),
        ),
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
                                    String title = _title.text;
                                    String note = _note.text;
                                    String startDate = _startDate.text;
                                    String endDate = _endDate.text;
                                    String location = _location.text;
                                    bool? reminder = _reminder;
                                    double progress = _progress;
                                    String? meetingId = _valueMeeting;
                                    if (meetingId != null) {
                                      var response = await updateMeeting(
                                        meetingId,
                                        title,
                                        note,
                                        startDate,
                                        endDate,
                                        location,
                                        reminder,
                                        progress,
                                      );
                                      if (response != null) {
                                        Get.snackbar("Successed",
                                            "You have updated meeting.",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor,
                                            showProgressIndicator: true);
                                        Provider.of<MeetingProvider>(context,
                                                listen: false)
                                            .createUpdate(response);
                                        widget.onUpdated(response);
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "New Meeting",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 400,
                      height: 50,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _title,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Title",
                          hintStyle: TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabled: true,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0, color: Colors.red),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title field requires';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      width: 400,
                      height: 100,
                      alignment: Alignment.center,
                      child: TextFormField(
                        maxLines: 100,
                        controller: _note,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Note",
                          hintStyle: TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabled: true,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0, color: Colors.red),
                            borderRadius: BorderRadius.circular(29),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      "Additional Information (Optional)",
                      style: TextStyle(fontFamily: "Family Name", fontSize: 19),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 180,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "../../../../../assets/icons/calender.svg"),
                                  SizedBox(width: 10),
                                  (_seletedDate == null)
                                      ? Text(
                                          "Start Date",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        )
                                      : Text(
                                          "${_seletedDate}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            width: 180,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _selectEndDate(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "../../../../../assets/icons/calender.svg"),
                                  SizedBox(width: 10),
                                  (_seletedEndDate == null)
                                      ? Text(
                                          "End Date",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        )
                                      : Text(
                                          "${_seletedEndDate}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 150,
                            child: GoogleMaps(),
                          ),
                          Container(
                            width: 400,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(11.0),
                                bottomRight: Radius.circular(11.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.pin_drop_sharp, color: Colors.red),
                                SizedBox(width: 18),
                                Text(
                                  "Location",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 17),
                    Container(
                      width: 400,
                      height: 50,
                      child: TextFormField(
                        controller: _location,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Location",
                          hintStyle: TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabled: true,
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0, color: Colors.red),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 8),
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Reminder",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          FlutterSwitch(
                            width: 55.0,
                            height: 25.0,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            value: _reminder,
                            onToggle: (val) {
                              setState(() {
                                _reminder = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Progress",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 250,
                            child: Slider(
                              value: _progress,
                              activeColor: kPrimaryColor,
                              max: 100,
                              divisions: 10,
                              label: _progress.toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _progress = value;
                                });
                              },
                            ),
                          ),
                          // SizedBox(width: 5),
                          Text("$_progress" + "%")
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: SvgPicture.asset(
                                "../../../../../assets/icons/file.svg"),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Text("Choose File or Image"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
