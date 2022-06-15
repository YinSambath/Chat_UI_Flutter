import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/action_planning_model.dart';

class ActionPlanningProvider with ChangeNotifier {
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

  ActionPlanningDataModel? _actionPlanningData;
  ActionPlanningDataModel? get actionData => _actionPlanningData;

  _setActionData(ActionPlanningDataModel data) {
    _actionPlanningData = data;
    _setState(NotifierState.loaded);
  }


 ShortActionPlanningModel? _shortData;
  ShortActionPlanningModel? get shortData => _shortData;

  
  _setShortData(ShortActionPlanningModel dataShort) {
    _shortData = dataShort;
    _setState(NotifierState.loaded);
  }

  void getActionData(String planningId) async {
    _setState(NotifierState.loading);
    actionPlanning(planningId).then((value) {
      if (_actionPlanningData != "") {
        _setActionData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(ActionPlanningModel data) {
    if (_actionPlanningData != null && _actionPlanningData!.data!.isNotEmpty) {
      int _index = _actionPlanningData!.data!
          .indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _actionPlanningData!.data![_index] = data;
        notifyListeners();
      } else {
        _actionPlanningData!.data!.insert(0, data);
        notifyListeners();
      }
    }
    if (_actionPlanningData != null && _actionPlanningData!.data!.isEmpty) {
      _actionPlanningData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_actionPlanningData == null) {
      _setActionData(ActionPlanningDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchAction(String planningId, String search) async {
    _setState(NotifierState.loading);
    searchActionPlanning(planningId, search).then((value) {
      if (_actionPlanningData != "") {
        _setActionData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getShortData() {
    _setState(NotifierState.loading);
    shortActionPlanning().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void shortAllData() {
    _setState(NotifierState.loading);
    shortAllActionPlanning().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

}
