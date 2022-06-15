import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mcircle_project_ui/Providers/folder_provider.dart';
import 'package:mcircle_project_ui/Providers/todo_provider.dart';
import 'package:mcircle_project_ui/Views/Screens/Productivity/components/widgets/google_map.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class CreateTodo extends StatefulWidget {
  FolderModel? folder;
  CreateTodo({
    Key? key,
    this.folder,
  }) : super(key: key);
  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  final repeatList = ["Daily", "Weakly", "Monthly"];
  final priorityList = [
    "None",
    "Low",
    "Medium",
    "High",
    "Very High",
    "Critical"
  ];
  var myMarkers;
  String? _valueRepeat;
  String? _resultRepeat;
  String? _valuePriority;
  String? _resultPriority;
  String? _valueFolder;
  bool status = false;
  List<DropdownMenuItem<String>> _createRepeat() {
    return repeatList
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<String>> _createPriority() {
    return priorityList
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }

  FolderModel? getFolder;
  TextEditingController _title = TextEditingController();
  TextEditingController _dateTime = TextEditingController();
  TextEditingController _note = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _endDob = TextEditingController();
  TextEditingController _priority = TextEditingController();
  TextEditingController _repeat = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");
  var selectedDate;
  var selectedEndDate;
  String? _seletedDate;
  String? _seletedEndDate;
  double _currentSliderValue = 0;
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
        _dateTime.text = _seletedDate!;
      });
    }
  }

  _endDate(BuildContext context) async {
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
        _endDob.text = _seletedEndDate!;
      });
    }
  }

  @override
  void initState() {
    getFolder = widget.folder;
    _valueFolder = getFolder!.sId!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.vertical,
      child: Container(
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
                                    final bool _isValid =
                                        _formKey.currentState!.validate();
                                    if (_isValid) {
                                      String folderId = _valueFolder!;
                                      String title = _title.text;
                                      String note = _note.text;
                                      String dateTime = _dateTime.text;
                                      String repeat = _repeat.text;
                                      String endRepeat = _endDob.text;
                                      String location = _location.text;
                                      String priority = _priority.text;
                                      bool? reminder = status;
                                      double progress = _currentSliderValue;
                                      var response = await createTodo(
                                        folderId,
                                        title,
                                        note,
                                        dateTime,
                                        repeat,
                                        endRepeat,
                                        location,
                                        priority,
                                        reminder,
                                        progress,
                                      );
                                      if (response != null) {
                                        Get.snackbar("Successed",
                                            "You have updated todo.",
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.TOP,
                                            margin: EdgeInsets.only(left: 1230),
                                            maxWidth: 300,
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 3),
                                            overlayColor: kPrimaryColor,
                                            showProgressIndicator: true);
                                        Provider.of<TodoProvider>(context,
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
                            SizedBox(height: 18),
                            Text(
                              "New Task",
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
                    Container(
                      width: 400,
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
                    SizedBox(height: 18),
                    Container(
                      width: 400,
                      height: 150,
                      child: GoogleMaps(),
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
                      width: 400,
                      height: 50,
                      child: SizedBox(
                        width: 400,
                        height: 35,
                        child: DropdownButtonFormField2<String>(
                          items: _createRepeat(),
                          value: _valueRepeat,
                          onChanged: (String? newValue) {
                            _valueRepeat = newValue!;
                            _repeat.text = _valueRepeat!;
                          },
                          // style
                          selectedItemBuilder: (BuildContext context) {
                            return repeatList.map((String value) {
                              return Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black,
                                  decorationColor: Colors.transparent,
                                ),
                              );
                            }).toList();
                          },
                          decoration: InputDecoration(
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
                          ),
                          alignment: Alignment.centerLeft,
                          focusColor: Colors.transparent,
                          hint: Row(
                            children: [
                              Text("Choose a Repeat",
                                  style: TextStyle(color: kPrimaryColor)),
                            ],
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: kPrimaryColor,
                          ),
                          isExpanded: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _endDate(context);
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
                    SizedBox(height: 18),
                    Container(
                      width: 400,
                      height: 50,
                      child: SizedBox(
                        width: 400,
                        height: 35,
                        child: DropdownButtonFormField2<String>(
                          items: _createPriority(),
                          value: _valuePriority,
                          onChanged: (String? newValue) {
                            _valuePriority = newValue!;
                            _priority.text = _valuePriority!;
                          },
                          // style
                          selectedItemBuilder: (BuildContext context) {
                            return priorityList.map((String value) {
                              return Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black,
                                  decorationColor: Colors.transparent,
                                ),
                              );
                            }).toList();
                          },
                          decoration: InputDecoration(
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
                          ),
                          alignment: Alignment.centerLeft,
                          focusColor: Colors.transparent,
                          hint: Row(
                            children: [
                              Text("Choose Priority",
                                  style: TextStyle(color: kPrimaryColor)),
                            ],
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: kPrimaryColor,
                          ),
                          isExpanded: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Consumer<FolderProvider>(builder: (__, notifier, child) {
                      child = Container(
                        width: 400,
                        height: 60,
                        child: DropdownButtonFormField2<String>(
                            items: notifier.folderData?.data!
                                .map<DropdownMenuItem<String>>(
                                    (FolderModel data) {
                              return DropdownMenuItem<String>(
                                value: data.sId,
                                child: Text(data.name!),
                              );
                            }).toList(),
                            value: _valueFolder,
                            onChanged: (String? newValue) {
                              _valueFolder = newValue;
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
                                Text("Choose Folder",
                                    style: TextStyle(color: kPrimaryColor)),
                              ],
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: kPrimaryColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field require!!!";
                              }
                              return null;
                            }),
                      );
                      return child;
                    }),
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
                            value: status,
                            onToggle: (val) {
                              setState(() {
                                status = val;
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
                              value: _currentSliderValue,
                              activeColor: kPrimaryColor,
                              max: 100,
                              divisions: 10,
                              label: _currentSliderValue.toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValue = value;
                                });
                              },
                            ),
                          ),
                          // SizedBox(width: 5),
                          Text("$_currentSliderValue" + "%")
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
