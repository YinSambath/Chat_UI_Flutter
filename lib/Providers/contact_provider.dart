import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/user_model.dart';
import 'package:mcircle_project_ui/Perferrences/share_perfs.dart';

class ContactProvider with ChangeNotifier {
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

  ContactDataModel? _contactData;
  ContactDataModel? get contactData => _contactData;

  _setContactData(ContactDataModel data) {
    _contactData = data;
    _setState(NotifierState.loaded);
  }

  void getContactData() async {
    _setState(NotifierState.loading);
    listContact().then((value) {
      if (_contactData != "") {
        _setContactData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getSearchContact(String search) async {
    _setState(NotifierState.loading);
    searchContact(search).then((value) {
      if (_contactData != "") {
        _setContactData(value);
        _setState(NotifierState.loaded);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(ContactModel data) {
    if (_contactData != null && _contactData!.data!.isNotEmpty) {
      int _index =
          _contactData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _contactData!.data![_index] = data;
      } else {
        _contactData!.data!.insert(0, data);
      }
    }
    if (_contactData != null && _contactData!.data!.isEmpty) {
      _contactData!.data!.insert(0, data);
    }
    if (_contactData == null) {
      _setContactData(ContactDataModel(data: [data]));
    }
      notifyListeners();
  }
}
