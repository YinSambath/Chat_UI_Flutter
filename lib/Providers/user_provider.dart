import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/user_model.dart';
import 'package:mcircle_project_ui/Perferrences/share_perfs.dart';

class UserProvider with ChangeNotifier {
  final PrefService _prefs = PrefService();
  NotifierState _state = NotifierState.inital;
  NotifierState get state => _state;

  void setState(NotifierState notifierState) {
    _state = notifierState;
    notifyListeners();
  }

  _setState(NotifierState notifierState) {
    _state = notifierState;
    notifyListeners();
  }

  UserModel? _userData;
  UserModel? get userData => _userData;

  _setUserData(UserModel data) {
    _userData = data;
    _setState(NotifierState.loaded);
  }

  UserDataModel? _dataUsers;
  UserDataModel? get dataUser => _dataUsers;

  _setDataUser(UserDataModel data) {
    _dataUsers = data;
    _setState(NotifierState.loaded);
  }

  void getListUser() async {
    _setState(NotifierState.loading);
    listUser().then((value) {
      if (_dataUsers != "") {
        _setDataUser(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getDataUser() async {
    _setState(NotifierState.loading);
    var _user = await _prefs.readState("user");
    Map<String, dynamic> _data = jsonDecode(_user);
    UserModel _userData = UserModel.fromJson(_data);
    if (_userData != "") {
      _setUserData(_userData);
    } else {
      _setState(NotifierState.loaded);
    }
  }

}
