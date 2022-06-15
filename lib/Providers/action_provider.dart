import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/action_model.dart';

class ActionProvider with ChangeNotifier {
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

  ActionDataModel? _actionData;
  ActionDataModel? get actionData => _actionData;

  _setActionData(ActionDataModel data) {
    _actionData = data;
    _setState(NotifierState.loaded);
  }

  ShortActionModel? _shortData;
  ShortActionModel? get shortData => _shortData;


  _setShortData(ShortActionModel dataShort) {
    _shortData = dataShort;
    _setState(NotifierState.loaded);
  }


  void getActionData(String tripId) async {
    _setState(NotifierState.loading);
    listAction(tripId).then((value) {
      if (_actionData != "") {
        _setActionData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(ActionModel data) {
    if (_actionData != null && _actionData!.data!.isNotEmpty) {
      int _index =
          _actionData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _actionData!.data![_index] = data;
        print(_actionData!.data![_index].title);
        print(data.title);
        notifyListeners();
      } else {
        _actionData!.data!.insert(0, data);
        notifyListeners();
      }
    }
    if (_actionData != null && _actionData!.data!.isEmpty) {
      _actionData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_actionData == null) {
      _setActionData(ActionDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchAction(String search, String tripId) async {
    _setState(NotifierState.loading);
    searchAction(search, tripId).then((value) {
      if (_actionData != "") {
        _setActionData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getShortData() {
    _setState(NotifierState.loading);
    shortActionTrip().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void shortAllData() {
    _setState(NotifierState.loading);
    shortAllActionTrip().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
}
