import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/Providers/action_provider.dart';
import 'package:mcircle_project_ui/Providers/trip_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/widgets/google_map.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: must_be_immutable
class CreateTripAction extends StatefulWidget {
  TripModel? tripData;
  CreateTripAction({
    Key? key,
    this.tripData,
  }) : super(key: key);
  @override
  State<CreateTripAction> createState() => _CreateTripActionState();
}

class _CreateTripActionState extends State<CreateTripAction> {
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _priority = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _valueTrip;
  bool _reminder = false;
  double _progress = 0;
  var selectedDate;
  var selectedEndDate;
  String? _seletedDate;
  String? _seletedEndDate;
  String? _valueMember;
  double? getLat;
  double? getLng;
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");
  List<ContactModel> _listContact = [];
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

  callBackLat(double value) {
    setState(() {
      getLat = value;
    });
    print(value);
  }
  callBackLng(double value) {
    setState(() {
      getLng = value;
    });
    print(value);
  }


  @override
  void initState() {
    if (widget.tripData != null) {
      _valueTrip = widget.tripData!.sId!;
      getListMember();
    }
    super.initState();
  }
void getListMember() async {
  final list = await getListTripUser(widget.tripData!.sId!);
  if (list != null) {
    setState(() {
      _listContact = list;
    });
    print(_listContact);
  } else {
    print("null");
  }
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller:  ScrollController(),
      child: Container(
        width: 400,
        height: 1000,
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
                                    // String priority = _priority.text;
                                    bool? reminder = _reminder;
                                    double progress = _progress;
                                    String? tripId = _valueTrip;
                                    print(2);
                                    if (tripId != null) {
                                      String? assignTo = (_valueMember!= null) ? _valueMember! : null;
                                      print(3);
                                      var response = await createAction(
                                        title,
                                        note,
                                        startDate,
                                        endDate,
                                        location,
                                        tripId,
                                        reminder,
                                        progress,
                                        assignTo!
                                      );
                                      if (response != null) {
                                        Get.snackbar(
                                            "Successed", "You have created action in this trip.",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor,
                                            showProgressIndicator: true);
                                        Provider.of<ActionProvider>(context,
                                                listen: false)
                                            .createUpdate(response);
                                        Navigator.of(context).pop();
                                      }
                                    } else {
                                    double? lat = getLat;
                                    double? lng = getLng;
                                    print(lat);
                                    print(lng);
                                      print(4);
                                      var response = await createTrip(
                                        title,
                                        note,
                                        startDate,
                                        endDate,
                                        lat,
                                        lng,
                                        location,
                                        reminder,
                                        progress,
                                      );
                                      if (response != null) {
                                        Get.snackbar(
                                            "Successed", "You have created trip.",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor,
                                            showProgressIndicator: true);
                                        Provider.of<TripProvider>(context,
                                                listen: false)
                                            .createUpdate(response);
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
                              "New Trip",
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
                            return 'Fullname field requires';
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
                                          "DateTime",
                                          style: TextStyle(color: kPrimaryColor),
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
                                          "End-Date",
                                          style: TextStyle(color: kPrimaryColor),
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
                    InkWell(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              width: 400,
                              height: 150,
                              child: GoogleMaps(lat: callBackLat, lng: callBackLng),
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
                    ),
                    SizedBox(height: 18),
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
                    Consumer<TripProvider>(builder: (__, notifier, child) {
                      child = Container(
                        width: 400,
                        height: 60,
                        child: DropdownButtonFormField2<String>(
                          items: notifier.tripData?.data!
                              .map<DropdownMenuItem<String>>((TripModel data) {
                            return DropdownMenuItem<String>(
                              value: data.sId,
                              child: Text(data.title!),
                            );
                          }).toList(),
                          value: _valueTrip,
                          onChanged: (String? newValue) {
                            _valueTrip = newValue;
                          },
                          decoration: InputDecoration(
                              hoverColor: Colors.transparent,
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(11),
                              )),
                          alignment: Alignment.centerLeft,
                          focusColor: Colors.transparent,
                          hint: Row(
                            children: [
                              Text("Choose main trip",
                                  style: TextStyle(color: kPrimaryColor)),
                            ],
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                      );
                      return child;
                    }),
                    SizedBox(height: 18),
                    (widget.tripData != null)?Container(
                      width: 400,
                      height: 60,
                      child: DropdownButtonFormField2<String>(
                        items: _listContact
                            .map<DropdownMenuItem<String>>((ContactModel data) {
                          return DropdownMenuItem<String>(
                            value: data.sId,
                            child: (data.firstname == null || data.lastname ==null)?Text("${data.phone}", style: TextStyle(fontSize: 10, color: Colors.black),):Text(data.firstname! + data.lastname!),
                          );
                        }).toList(),
                        value:_valueMember,
                        onChanged: (String? newValue) {
                          _valueMember = newValue;
                        },
                        decoration: InputDecoration(
                            hoverColor: Colors.transparent,
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(11),
                            )),
                        alignment: Alignment.centerLeft,
                        focusColor: Colors.transparent,
                        hint: Row(
                          children: [
                            Text("Assign to",
                                style: TextStyle(color: kPrimaryColor)),
                          ],
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: kPrimaryColor,
                        ),
                      ),
                    ):SizedBox(),
                    (widget.tripData != null)?SizedBox(height: 18):SizedBox(),
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
