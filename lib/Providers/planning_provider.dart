import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/planning_model.dart';

class PlanningProvider with ChangeNotifier {
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

  PlanningDataModel? _planningData;
  PlanningDataModel? get planningData => _planningData;

  _setPlanningData(PlanningDataModel data) {
    _planningData = data;
    _setState(NotifierState.loaded);
  }

  void getPlanningData(int page) async {
    _setState(NotifierState.loading);
    listPlanning(page).then((value) {
      if (_planningData != "") {
        _setPlanningData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(PlanningModel data) {
    if (_planningData != null && _planningData!.data!.isNotEmpty) {
      int _index =
          _planningData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _planningData!.data![_index] = data;
        print(_planningData!.data![_index].title);
        print(data.title);
        notifyListeners();
      } else {
        if (_planningData!.totalDocs! % 10 == 0) {
          _planningData!.totalPages = _planningData!.totalPages! + 1;
        }
        _planningData!.data!.insert(0, data);
        notifyListeners();
      }
    }
    if (_planningData != null && _planningData!.data!.isEmpty) {
      _planningData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_planningData == null) {
      _setPlanningData(PlanningDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchPlanning(String search) async {
    _setState(NotifierState.loading);
    searchPlanning(search).then((value) {
      if (_planningData != "") {
        _setPlanningData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
}
