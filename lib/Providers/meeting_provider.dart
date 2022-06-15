import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/meeting_model.dart';

class MeetingProvider with ChangeNotifier {
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

  MeetingDataModel? _meetingData;
  MeetingDataModel? get meetingData => _meetingData;

  _setMeetingData(MeetingDataModel data) {
    _meetingData = data;
    _setState(NotifierState.loaded);
  }

  void getMeetingData(int page) async {
    _setState(NotifierState.loading);
    listMeeting(page).then((value) {
      if (_meetingData != "") {
        
        _setMeetingData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(MeetingModel data) {
    if (_meetingData != null && _meetingData!.data!.isNotEmpty) {
      int _index =
          _meetingData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _meetingData!.data![_index] = data;
        print(_meetingData!.data![_index].title);
        print(data.title);
        notifyListeners();
      } else {
        
        if(_meetingData!.totalDocs! %10==0){
          _meetingData!.totalPages = _meetingData!.totalPages! + 1;
        } 
        _meetingData!.data!.insert(0, data);
        
        notifyListeners();
      }
    }
    if (_meetingData != null && _meetingData!.data!.isEmpty) {
      _meetingData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_meetingData == null) {
      _setMeetingData(MeetingDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchMeeting(String search) async {
    _setState(NotifierState.loading);
    searchMeeting(search).then((value) {
      if (_meetingData != "") {
        _setMeetingData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
}
