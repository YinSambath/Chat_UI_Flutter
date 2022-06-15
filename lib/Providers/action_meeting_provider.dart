import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/action_meeting_model.dart';

class ActionMeetingProvider with ChangeNotifier {
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

  ActionMeetingDataModel? _actionData;
  ActionMeetingDataModel? get actionData => _actionData;

  _setActionData(ActionMeetingDataModel data) {
    _actionData = data;
    _setState(NotifierState.loaded);
  }


 ShortActionMeetingModel? _shortData;
  ShortActionMeetingModel? get shortData => _shortData;

  
  _setShortData(ShortActionMeetingModel dataShort) {
    _shortData = dataShort;
    _setState(NotifierState.loaded);
  }

  void getActionData(String meetingId) async {
    _setState(NotifierState.loading);
    actionMeeting(meetingId).then((value) {
      if (_actionData != "") {
        _setActionData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(ActionMeetingModel data) {
    if (_actionData != null && _actionData!.data!.isNotEmpty) {
      int _index =
          _actionData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _actionData!.data![_index] = data;
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
      _setActionData(ActionMeetingDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchAction(String meetingId, String search) async {
    _setState(NotifierState.loading);
    searchActionMeeting(meetingId, search).then((value) {
      if (_actionData != "") {
        _setActionData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getShortData() {
    _setState(NotifierState.loading);
    shortActionMeeting().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void shortAllData() {
    _setState(NotifierState.loading);
    shortAllActionMeeting().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
}
