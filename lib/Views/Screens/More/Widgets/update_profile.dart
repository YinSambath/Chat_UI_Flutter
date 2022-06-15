import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Providers/user_provider.dart';
import 'package:mcircle_project_ui/chat_app.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final background = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;

  late TextEditingController _email;
  late TextEditingController _phone;
  TextEditingController _dob = TextEditingController();
  TextEditingController _status = TextEditingController();
  late TextEditingController _firstname;
  late TextEditingController _lastname;
  late TextEditingController _username;
  TextEditingController _gender = TextEditingController();
  late TextEditingController _website;
  late TextEditingController _nationality;
  late TextEditingController _address;
  String? _valueGen;
  String? _valueStatus;
  late String _resultGen = "";
  late String _resultStatus = "";
  final genList = ["Male", "Female"];
  final statusList = ["Single", "Married"];
  String? fullname;
  String? username;
  String? phone;
  String? nationality;
  final _formKey = GlobalKey<FormState>();
  var selectedDate;
  String? _seletedDate;
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");
  List<DropdownMenuItem<String>> _createGen() {
    return genList
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<String>> _createStatus() {
    return statusList
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1955),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
      _seletedDate = dateFormat.format(selectedDate);
      _dob.text = _seletedDate!;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getDataUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        width: 400,
        child: Drawer(
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Container(
                child: Consumer<UserProvider>(
                  builder: (__, notifier, child) {
                    UserModel _user = notifier.userData!;
                    _email = TextEditingController(text: "${_user.email}");
                    _firstname =
                        TextEditingController(text: "${_user.firstname}");
                    _lastname =
                        TextEditingController(text: "${_user.lastname}");
                    _username =
                        TextEditingController(text: "${_user.username}");
                    _dob = TextEditingController(text: "${_user.dob}");
                    _phone = TextEditingController(text: "${_user.phone}");
                    _website = TextEditingController(text: "${_user.website}");
                    _address = TextEditingController(text: "${_user.address}");
                    _nationality =
                        TextEditingController(text: "${_user.nationality}");
                    _seletedDate = _user.dob;
                    _valueGen = _user.gender;
                    _valueStatus = _user.status;
                    if (notifier.userData == null &&
                        notifier.state == NotifierState.loading) {
                      child = const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (notifier.userData != null &&
                        notifier.state == NotifierState.loaded) {
                      child = Column(
                        children: [
                          Container(
                            height: 100,
                            child: DrawerHeader(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            bool _isValid = _formKey
                                                .currentState!
                                                .validate();
                                            if (_isValid) {
                                              _gender.text = _resultGen;
                                              _status.text = _resultStatus;
                                              _dob.text = _seletedDate!;
                                              String firstname =
                                                  _firstname.text;
                                              String lastname = _lastname.text;
                                              String username = _username.text;
                                              String email = _email.text;
                                              String gender = _gender.text;
                                              String dob = _dob.text;
                                              String phone = _phone.text;
                                              String nationality =
                                                  _nationality.text;
                                              String status = _status.text;
                                              String website = _website.text;
                                              String address = _address.text;

                                              var response =
                                                  await updateProfile(
                                                firstname,
                                                lastname,
                                                username,
                                                email,
                                                gender,
                                                dob,
                                                phone,
                                                nationality,
                                                status,
                                                website,
                                                address,
                                              );
                                              if (response == 200) {
                                                setState(() {
                                                  Get.snackbar("Updated!",
                                                      "You have updated your information.");
                                                  Navigator.of(context).pop();
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .getDataUser();
                                                });
                                              } else {
                                                Get.snackbar("error", "....!");
                                              }
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
                                  Text(
                                    "Update profile",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Firstname: "),
                                    SizedBox(height: 8),
                                    RoundedInputField(
                                      hintText: "Input username here...",
                                      width: 100,
                                      height: 45,
                                      controller: _firstname,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Fullname field requires';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) => {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Lastname: "),
                                    SizedBox(height: 8),
                                    RoundedInputField(
                                      hintText: "Input username here...",
                                      width: 100,
                                      height: 45,
                                      controller: _lastname,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Fullname field requires';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) => {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Username: "),
                              SizedBox(height: 8),
                              RoundedInputField(
                                hintText: "${_user.username}",
                                width: 280,
                                height: 50,
                                controller: _username,
                                onChanged: (String? value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username field requires';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sex: "),
                              SizedBox(height: 8),
                              Container(
                                width: 400,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(248, 248, 248, 1),
                                ),
                                child: SizedBox(
                                  width: 400,
                                  height: 55,
                                  child: DropdownButtonFormField2<String>(
                                    items: _createGen(),
                                    value: _valueGen!=null ? _valueGen :null,
                                    onChanged: (String? newValue) {
                                      _valueGen = newValue!;
                                      _resultGen = _valueGen!;
                                    },
                                    onSaved: (String? newValue) {
                                      newValue = _valueGen;
                                      _resultGen = newValue!;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Gender field requires';
                                      }
                                      return null;
                                    },
                                    // style
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return genList.map((String value) {
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
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              style: BorderStyle.solid,
                                              width: 0.80)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0, color: Colors.red),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    focusColor: Colors.transparent,
                                    hint: Text("Select item"),
                                    icon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: kPrimaryColor,
                                    ),
                                    isExpanded: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: 400,
                            height: 45,
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
                                  SizedBox(width: 5),
                                  (_seletedDate == null)
                                      ? Text(
                                          "DateTime",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : Text(
                                          "${_seletedDate}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email: "),
                              SizedBox(height: 8),
                              RoundedInputField(
                                width: 400,
                                height: 50,
                                hintText: "${_user.email}",
                                controller: _email,
                                onChanged: (value) => {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email field requires';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone: "),
                              SizedBox(height: 8),
                              RoundedInputNumberField(
                                width: 400,
                                height: 50,
                                controller: _phone,
                                hintText: "Mobile phone",
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone field requires';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nationality: "),
                              SizedBox(height: 8),
                              RoundedInputField(
                                width: 400,
                                height: 50,
                                hintText: "Nationality",
                                controller: _nationality,
                                onChanged: (value) => {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nationality field requires';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Material Status: "),
                              SizedBox(height: 8),
                              Container(
                                width: 400,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(248, 248, 248, 1),
                                ),
                                child: SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: DropdownButtonFormField2<String>(
                                    items: _createStatus(),
                                    value: _valueStatus!=null?_valueStatus:null,
                                    onChanged: (String? newStatus) {
                                      _valueStatus = newStatus!;
                                      _resultStatus = _valueStatus!;
                                    },
                                    onSaved: (String? newStatus) {
                                      newStatus = _valueStatus;
                                      _resultStatus = newStatus!;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Status field requires';
                                      }
                                      return null;
                                    },
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return statusList.map((String value) {
                                        return Text(
                                          value,
                                          style: TextStyle(
                                            color: Colors.black,
                                            decorationColor: Colors.transparent,
                                          ),
                                        );
                                      }).toList();
                                    },
                                    // Style
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0, color: Colors.red),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    ),
                                    hint: Text("Select item"),
                                    alignment: Alignment.centerLeft,
                                    focusColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: kPrimaryColor,
                                    ),
                                    isExpanded: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Website: "),
                              SizedBox(height: 8),
                              RoundedInputField(
                                width: 280,
                                height: 50,
                                hintText: "Website (optional)",
                                controller: _website,
                                onChanged: (value) => {},
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Adress: "),
                              SizedBox(height: 8),
                              RoundedInputField(
                                width: 280,
                                height: 50,
                                hintText: "Address",
                                controller: _address,
                                onChanged: (value) => {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Address field requires';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      child = const Center(
                        child: Text('no data'),
                      );
                    }
                    return child;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
