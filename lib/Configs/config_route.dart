import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mcircle_project_ui/Models/action_meeting_model.dart';
import 'package:mcircle_project_ui/Models/action_model.dart';
import 'package:mcircle_project_ui/Models/action_planning_model.dart';
import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';
import 'package:mcircle_project_ui/Models/meeting_model.dart';
import 'package:mcircle_project_ui/Models/planning_model.dart';
import 'package:mcircle_project_ui/Models/todo_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';
import 'package:mcircle_project_ui/constants.dart';
import '../Models/user_model.dart';
import '../Perferrences/share_perfs.dart';

final PrefService _prefs = PrefService();

Future<Object> signin(String phone, String password) async {
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/login'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone': phone,
      'password': password,
    }),
  );
  // print(response.body);
  Map<String, dynamic> decode_option = jsonDecode(response.body);

  if (response.statusCode == 200 && decode_option["newUser"] != null) {
    // UserModel userData = UserModel.fromJson(decode_option["user"]);
    UserModel user = UserModel.fromJson(decode_option["newUser"]);
    String data = jsonEncode(user);
    _prefs.createState("user", data);
    _prefs.createState("userID", user.sId!);
    // print(decode_option);
    // print(data);
    print("Login");
  }
  if (response.statusCode == 400) {
    Get.snackbar("Log in failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  if (response.statusCode == 500) {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  return response.statusCode;
}

Future signout() async {
  var _userId = await _prefs.readState("userID");
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.delete(
    Uri.parse('http://localhost:3000/api/user/logout'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      'phone': _userData.phone!,
    }),
  );
  if (response.statusCode == 200) {
    _prefs.removeState("user");
  }
  return response.statusCode;
}

Future<Object> signup(
    String firstname,
    String lastname,
    String username,
    String phone,
    String email,
    String password,
    String comfirmedPassword) async {
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/register'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'phone': phone,
      'password': password,
      'comfirmedPassword': comfirmedPassword,
      // ignore: sdk_version_ui_as_code
      if (email.isNotEmpty) 'email': email,
    }),
  );
  Map<String, dynamic> decode_option = jsonDecode(response.body);
  UserModel user = UserModel.fromJson(decode_option["savedUser"]);
  String data = jsonEncode(user);
  print(response.statusCode);
  if (response.statusCode == 200) {
    _prefs.createState("user", data);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  return response.statusCode;
}

Future<Object> checkPhone(String phone) async {
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/checkedPhone'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone': phone,
    }),
  );
  // print(response.body);
  var data = UserModel.fromJson(jsonDecode(response.body));
  if (response.statusCode == 200) {
    _prefs.createState("resetLink", data.resetLink!);
    return data;
  } else {
    print("Something is wrong!");
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  return response.statusCode;
}

Future<Object> resetPassword(String comfirmedPassword, String password) async {
  String _resetLink = await _prefs.readState("resetLink");
  // if (comfirmedPassword.isNotEmpty && password.isNotEmpty) {
  print(_resetLink);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/renewPassword'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'password': password,
      'comfirmedPassword': comfirmedPassword,
      'resetLink': _resetLink,
    }),
  );
  // print(password);
  // print(comfirmedPassword);
  // print("Hello 3");
  if (response.statusCode == 200) {
    print("Done!");
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  return response.statusCode;
}

Future<Object> changePassword(String currentPassword,
    String newComfirmedPassword, String newPassword) async {
  var _userId = await _prefs.readState("userID");
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  // print(_userId);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/changePassword'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      'id': _userId,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'newComfirmedPassword': newComfirmedPassword,
    }),
  );
  if (response.statusCode == 200) {
    print("Done!");
  } else {
    print(response.body);
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  return response.statusCode;
}

Future updateProfile(
  String firstname,
  String lastname,
  String username,
  String email,
  String gender,
  String dob,
  String phone,
  String nationality,
  String status,
  String website,
  String address,
) async {
  var _userId = await _prefs.readState("userID");
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  // print(_userId);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/update/${_userId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'gender': gender,
      'dob': dob,
      'phone': phone,
      'nationality': nationality,
      'status': status,
      'website': website,
      'address': address,
    }),
  );
  Map<String, dynamic> decode = jsonDecode(response.body);
  UserModel user = UserModel.fromJson(decode["user"]);
  String dataUpdate = jsonEncode(user);
  if (response.statusCode == 200) {
    _prefs.createState("user", dataUpdate);
    print("Done!");
  } else {
    print(response.body);
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
  return response.statusCode;
}

Future listUser() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    var decode_option = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return UserDataModel.fromJson(decode_option);
    } else {
      return response.statusCode;
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future createContact(String firstname, String lastname, String phone) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/contact/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      if (firstname.isNotEmpty) 'firstname': firstname,
      if (lastname.isNotEmpty) 'lastname': lastname,
      'phone': phone,
    }),
  );
  var decode_option = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("Create!");
    return ContactModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future listContact() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/contact/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    var decode_option = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ContactDataModel.fromJson(decode_option);
    } else {
      return response.statusCode;
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future searchContact(String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/contact/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ContactDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future updateContact(
    String sId, String firstname, String lastname, String phone) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/contact/update/$sId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      if (firstname.isNotEmpty) 'firstname': firstname,
      if (lastname.isNotEmpty) 'lastname': lastname,
      'phone': phone,
    }),
  );
  print(response.body);
  var decode_option = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    return ContactModel.fromJson(decode_option['contact']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deleteContact(String sId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/contact/delete/$sId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future createFolder(String name) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/folder/createFolder'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      'name': name,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return FolderModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future listFolder() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/folder/listFolder'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    // print(response.body);
    // print(decode_option);
    return FolderDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future updateFolder(String sId, String name) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/folder/update/$sId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode(<String, String>{
      'name': name,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return FolderModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deleteFolder(String sId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/folder/delete/$sId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future searchFolder(String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/folder/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return FolderDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future listTodo(String folderId, int page) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/todo/list?page=${page}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        "folderId": folderId
      })
    );
    print(response.body);
    if (response.statusCode != 200) {
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return TodoDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future createTodo(
  String folderId,
  String title,
  String note,
  String dateTime,
  String repeat,
  String endRepeat,
  String location,
  String priority,
  bool? reminder,
  double? progress,
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/todo/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'folderId': folderId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (dateTime.isNotEmpty) 'dateTime': dateTime, // repeat
      if (repeat.isNotEmpty) 'repeat': repeat,
      if (endRepeat.isNotEmpty) 'endRepeat': endRepeat,
      if (location.isNotEmpty) 'location': location,
      if (priority.isNotEmpty) 'priority': priority,
      if (reminder != null) 'reminder': reminder,
      if (progress != null) 'progress': progress,
    }),
  );
  print(priority);
  print(dateTime);
  print(response.body);
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return TodoModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future searchTodo(String search, String folderId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/todo/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        'folderId': folderId,
      }),
    );
    if (response.statusCode == 200) {
      var decode_option = jsonDecode(response.body);
      return TodoDataModel.fromJson(decode_option);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future deleteTodo(String folderId, String todoId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/todo/delete/$todoId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'folderId': folderId,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updateTodo(
  String folderId,
  String todoId,
  String title,
  String note,
  String dateTime,
  String repeat,
  String endRepeat,
  String location,
  String priority,
  bool? reminder,
  double? progress,
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/todo/update/${todoId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'folderId': folderId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (dateTime.isNotEmpty) 'dateTime': dateTime, // repeat
      if (repeat.isNotEmpty) 'repeat': repeat,
      if (endRepeat.isNotEmpty) 'endRepeat': endRepeat,
      if (location.isNotEmpty) 'location': location,
      if (priority.isNotEmpty) 'priority': priority,
      if (reminder != null) 'reminder': reminder,
      if (progress != null) 'progress': progress,
    }),
  );
  print(folderId);
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return TodoModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future markAsDone(String folderId, String todoId, bool mark) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/todo/markAsDone/$todoId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'folderId': folderId,
      'mark': mark,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return TodoModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future listTrip(int page) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/trip/list?page=${page}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    // print(response.body);
    // print(decode_option);
    return TripDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future searchTrip(String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/trip/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    return TripDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future createTrip(String title, String note, String startDate, String endDate, double? lat, double? lng,
    String location, bool reminder, double progress) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/trip/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return TripModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future listAction(String tripId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/actionTrip/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({'tripId': tripId}),
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    print(decode_option);
    return ActionDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future deleteTrip(String tripId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/trip/delete/$tripId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future searchAction(String search, String tripId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/actionTrip/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        'tripId': tripId,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var decode_option = jsonDecode(response.body);
      return ActionDataModel.fromJson(decode_option);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future createAction(String title, String note, String startDate, String endDate,
    String location, String tripId, bool reminder, double progress, String assignTo) async {
      print(4);
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/actionTrip/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'tripId': tripId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
      if(assignTo.isNotEmpty) 'assignTo': assignTo,
      
    }),
  );
  print(5);
  print(response.body);
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return ActionModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deleteAction(String tripId, String actionId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/actionTrip/delete/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'tripId': tripId,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updateTrip(
  String tripId,
  String title,
  String note,
  String startDate,
  String endDate,
  String location,
  bool reminder,
  double progress,
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/trip/update/${tripId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'repeat': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return TripModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updateAction(
  String tripId,
  String actionId,
  String title,
  String note,
  String startDate,
  String endDate,
  String location,
  bool reminder,
  double progress,
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/actionTrip/update/${actionId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'tripId': tripId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future markAction(String tripId, String actionId, bool mark) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/actionTrip/markDone/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'tripId': tripId,
      'mark': mark,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future actionReminder(String tripId, String actionId, bool reminder) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/actionTrip/reminder/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'tripId': tripId,
      'reminder': reminder,
    }),
  );
  print(reminder);
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future listMeeting(int page) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/meeting/list?page=${page}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return MeetingDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future listPlanning(int page) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/planning/list?page=${page}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    return PlanningDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future actionMeeting(String meetingId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/actionMeeting/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({'meetingId': meetingId}),
    );
    if (response.statusCode == 200) {
      var decode_option = jsonDecode(response.body);
      return ActionMeetingDataModel.fromJson(decode_option);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future actionPlanning(String planningId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/actionPlanning/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({'planningId': planningId}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var decode_option = jsonDecode(response.body);
      return ActionPlanningDataModel.fromJson(decode_option);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future searchPlanning(String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/planning/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    return PlanningDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future searchMeeting(String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/meeting/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode;
    }

    var decode_option = jsonDecode(response.body);
    return MeetingDataModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future createMeeting(String title, String note, String startDate,
    String endDate, String location, bool reminder, double progress) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/meeting/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return MeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updateMeeting(
    String meetingId,
    String title,
    String note,
    String startDate,
    String endDate,
    String location,
    bool reminder,
    double progress) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/meeting/update/${meetingId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return MeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future createPlanning(String title, String note, String startDate,
    String endDate, String location, bool reminder, double progress) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/planning/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return PlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updatePlanning(
    String planningId,
    String title,
    String note,
    String startDate,
    String endDate,
    String location,
    bool reminder,
    double progress) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/planning/update/${planningId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return PlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future createActionMeeting(
  String meetingId,
  String title,
  String note,
  String startDate,
  String endDate,
  String location,
  String repeat,
  String endRepeat,
  String priority,
  bool reminder,
  double progress,
  String assignTo
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/actionMeeting/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'meetingId': meetingId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      if (repeat.isNotEmpty) 'repeat': repeat,
      if (endRepeat.isNotEmpty) 'endRepeat': endRepeat,
      if (priority.isNotEmpty) 'priority': priority,
      'reminder': reminder,
      'progress': progress,
      if (assignTo.isNotEmpty) 'assignTo': assignTo,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return ActionMeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updateActionMeeting(
  String meetingId,
  String actionMeetingId,
  String title,
  String note,
  String startDate,
  String endDate,
  String location,
  String repeat,
  String endRepeat,
  String priority,
  bool reminder,
  double progress,
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse(
        'http://localhost:3000/api/user/actionMeeting/update/${actionMeetingId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'meetingId': meetingId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      if (repeat.isNotEmpty) 'repeat': repeat,
      if (endRepeat.isNotEmpty) 'endRepeat': endRepeat,
      if (priority.isNotEmpty) 'priority': priority,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionMeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future createActionPlanning(
  String planningId,
  String title,
  String note,
  String startDate,
  String endDate,
  String location,
  String repeat,
  String endRepeat,
  String priority,
  bool reminder,
  double progress,
  String assignTo
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.post(
    Uri.parse('http://localhost:3000/api/user/actionPlanning/create'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'planningId': planningId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      if (repeat.isNotEmpty) 'repeat': repeat,
      if (endRepeat.isNotEmpty) 'endRepeat': endRepeat,
      if (priority.isNotEmpty) 'priority': priority,
      'reminder': reminder,
      'progress': progress,
      if (assignTo.isNotEmpty) 'assignTo' : assignTo,
    }),
  ); 
  if (response.statusCode == 200) {
    print("Created!");
    var decode_option = jsonDecode(response.body);
    return ActionPlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future updateActionPlanning(
  String planningId,
  String actionPlanningId,
  String title,
  String note,
  String startDate,
  String endDate,
  String location,
  String repeat,
  String endRepeat,
  String priority,
  bool reminder,
  double progress,
) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse(
        'http://localhost:3000/api/user/actionPlanning/update/${actionPlanningId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'planningId': planningId,
      'title': title,
      if (note.isNotEmpty) 'note': note,
      if (startDate.isNotEmpty) 'startDate': startDate, // repeat
      if (endDate.isNotEmpty) 'endDate': endDate,
      if (location.isNotEmpty) 'location': location,
      if (repeat.isNotEmpty) 'repeat': repeat,
      if (endRepeat.isNotEmpty) 'endRepeat': endRepeat,
      if (priority.isNotEmpty) 'priority': priority,
      'reminder': reminder,
      'progress': progress,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionPlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deleteMeeting(String meetingId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/meeting/delete/$meetingId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deletePlanning(String planningId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/planning/delete/$planningId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deleteActionMeeting(String meetingId, String actionId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/actionmeeting/delete/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'meetingId': meetingId,
    }),
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future deleteActionPlanning(String planningId, String actionId) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.patch(
    Uri.parse('http://localhost:3000/api/user/actionPlanning/delete/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'planningId': planningId,
    }),
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future tripReminder(String tripId, bool reminder) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/trip/reminder/$tripId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'reminder': reminder,
    }),
  );
  print(reminder);
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return TripModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future meetingReminder(String meetingId, bool reminder) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/meeting/reminder/$meetingId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'reminder': reminder,
    }),
  );
  print(reminder);
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return MeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future planningReminder(String planningId, bool reminder) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse('http://localhost:3000/api/user/planning/reminder/$planningId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'reminder': reminder,
    }),
  );
  print(reminder);
  print(response.body);
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return PlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future planningActionReminder(
    String planningId, String actionId, bool reminder) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse(
        'http://localhost:3000/api/user/actionPlanning/reminder/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'planningId': planningId,
      'reminder': reminder,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionPlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future meetingActionReminder(
    String meetingId, String actionId, bool reminder) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse(
        'http://localhost:3000/api/user/actionMeeting/reminder/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'meetingId': meetingId,
      'reminder': reminder,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionMeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future markActionPlanning(String planningId, String actionId, bool mark) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse(
        'http://localhost:3000/api/user/actionPlanning/markDone/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'planningId': planningId,
      'mark': mark,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionPlanningModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(left: 1230),
      maxWidth: 300,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      overlayColor: kPrimaryColor);
  }
}

Future markActionMeeting(String meetingId, String actionId, bool mark) async {
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var response = await http.put(
    Uri.parse(
        'http://localhost:3000/api/user/actionMeeting/markDone/$actionId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': _userData.token!,
    },
    body: jsonEncode({
      'meetingId': meetingId,
      'mark': mark,
    }),
  );
  if (response.statusCode == 200) {
    print("Updated!");
    var decode_option = jsonDecode(response.body);
    return ActionMeetingModel.fromJson(decode_option['data']);
  } else {
    Get.snackbar("Failed", "Please Try again",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 1230),
        maxWidth: 300,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        overlayColor: kPrimaryColor);
  }
}

Future searchActionPlanning(String planningId, String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse(
          'http://localhost:3000/api/user/actionplanning/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        'planningId': planningId,
      }),
    );
    if (response.statusCode == 200) {
      var decode_option = jsonDecode(response.body);
      return ActionPlanningDataModel.fromJson(decode_option);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future searchActionMeeting(String meetingId, String search) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse(
          'http://localhost:3000/api/user/actionMeeting/?search=${search}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        'meetingId': meetingId,
      }),
    );
    if (response.statusCode == 200) {
      var decode_option = jsonDecode(response.body);
      return ActionMeetingDataModel.fromJson(decode_option);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortTodo() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/todo/shortToday'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    print(response.body);
    var decode_option = jsonDecode(response.body);
    return ShortTodoModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortActionTrip() async {
    try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/actionTrip/shortToday'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortActionModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortActionMeeting() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/actionMeeting/shortToday'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortActionMeetingModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortActionPlanning() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/actionPlanning/shortToday'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortActionPlanningModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortAllTodo() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/todo/shortAll'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortTodoModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortAllActionTrip() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/actionTrip/shortAll'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortActionModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortAllActionMeeting() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/actionMeeting/shortAll'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortActionMeetingModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future shortAllActionPlanning() async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/actionPlanning/shortAll'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    if (response.statusCode != 200) {
      print(response.statusCode);
      return response.statusCode;
    }
    var decode_option = jsonDecode(response.body);
    return ShortActionPlanningModel.fromJson(decode_option);
  } catch (err) {
    print(err);
    return null;
  }
}

Future addUser(List<String> selectedUser, String tripId) async {
    try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/trip/addUser/${tripId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        "user": selectedUser
      }),
    );
    if (response.statusCode == 200) {
    var decode_option = jsonDecode(response.body);
    return TripModel.fromJson(decode_option['data']);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future meetingAddUser(List<String> selectedUser, String meetingId) async {
    try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/meeting/addUser/${meetingId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        "user": selectedUser
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
    var decode_option = jsonDecode(response.body);
    return TripModel.fromJson(decode_option['data']);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future planningAddUser(List<String> selectedUser, String planningId) async {
    try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/user/planning/addUser/${planningId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
      body: jsonEncode({
        "user": selectedUser
      }),
    );
    if (response.statusCode == 200) {
    var decode_option = jsonDecode(response.body);
    return TripModel.fromJson(decode_option['data']);
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future getListTripUser(String tripId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get( Uri.parse('http://localhost:3000/api/user/trip/${tripId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
    var decode_option = jsonDecode(response.body);
    List<ContactModel> list = (decode_option['trip']['contact'] as List).map((e) => ContactModel.fromJson(e)).toList();
    return list;
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future getListMeetingUser(String meetingId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get( Uri.parse('http://localhost:3000/api/user/meeting/${meetingId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
    var decode_option = jsonDecode(response.body);
    List<ContactModel> list = (decode_option['meeting']['contact'] as List).map((e) => ContactModel.fromJson(e)).toList();
    return list;
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future getListPlanningUser(String planningId) async {
  try {
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    var response = await http.get( Uri.parse('http://localhost:3000/api/user/planning/${planningId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': _userData.token!,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
    var decode_option = jsonDecode(response.body);
    List<ContactModel> list = (decode_option['planning']['contact'] as List).map((e) => ContactModel.fromJson(e)).toList();
    return list;
    }
  } catch (err) {
    print(err);
    return null;
  }
}

Future uploadOrUpdateImage(PlatformFile file) async{
  var _user = await _prefs.readState("user");
  Map<String, dynamic> _data = jsonDecode(_user);
  UserModel _userData = UserModel.fromJson(_data);
  var request = http.MultipartRequest("POST", Uri.parse("http://localhost:3000/api/user/uploadOrUpdate/${_userData.sId}"));
  request.headers['Content-Type'] = 'application/json; charset=UTF-8';
  request.headers['auth-token'] = "${ _userData.token!}";

  request.files.add(new http.MultipartFile("newProfile", file.readStream!, file.size, filename: file.name));
  var response = await request.send();
  if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    print(result);
    Map<String, dynamic> decode = jsonDecode(result);
    UserModel user = UserModel.fromJson(decode["data"]);
    String dataUpdate = jsonEncode(user);
    _prefs.createState("user", dataUpdate);
    return response.statusCode;
  } else {
      Get.snackbar("Failed", "Please Try again",
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(left: 1230),
      maxWidth: 300,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      overlayColor: kPrimaryColor);
  }
}