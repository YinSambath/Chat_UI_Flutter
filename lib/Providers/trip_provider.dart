import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/todo_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';

class TripProvider with ChangeNotifier {
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

  TripDataModel? _tripData;
  TripDataModel? get tripData => _tripData;

  _setTripData(TripDataModel data) {
    _tripData = data;
    _setState(NotifierState.loaded);
  }

  void getTripData(int page) async {
    _setState(NotifierState.loading);
    listTrip(page).then((value) {
      if (_tripData != "") {
        _setTripData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(TripModel data) {
    if (_tripData != null && _tripData!.data!.isNotEmpty) {
      int _index =
          _tripData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _tripData!.data![_index] = data;
        print(_tripData!.data![_index].title);
        print(data.title);
        notifyListeners();
      } else {
        if (_tripData!.totalDocs! % 10 == 0) {
          _tripData!.totalPages = _tripData!.totalPages! + 1;
        }
        _tripData!.data!.insert(0, data);
        notifyListeners();
      }
    }
    if (_tripData != null && _tripData!.data!.isEmpty) {
      _tripData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_tripData == null) {
      _setTripData(TripDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchTrip(String search) async {
    _setState(NotifierState.loading);
    searchTrip(search).then((value) {
      if (_tripData != "") {
        _setTripData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
}
