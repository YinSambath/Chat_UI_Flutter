import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/folder_model.dart';

class FolderProvider with ChangeNotifier {
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

  FolderDataModel? _folderData;
  FolderDataModel? get folderData => _folderData;

  _setFolderData(FolderDataModel data) {
    _folderData = data;
    _setState(NotifierState.loaded);
  }

  void getFolderData() async {
    _setState(NotifierState.loading);
    listFolder().then((value) {
      if (_folderData != "") {
        _setFolderData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getSearchFolder(String search) async {
    _setState(NotifierState.loading);
    searchFolder(search).then((value) {
      if (_folderData != "") {
        _setFolderData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(FolderModel data) {
    if (_folderData != null && _folderData!.data!.isNotEmpty) {
      int _index =
          _folderData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _folderData!.data![_index] = data;
        print(_folderData!.data![_index].name);
        print(data.name);
        notifyListeners();
      } else {
        _folderData!.data!.insert(0, data);
        notifyListeners();
      }
    }
    if (_folderData != null && _folderData!.data!.isEmpty) {
      _folderData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_folderData == null) {
      _setFolderData(FolderDataModel(data: [data]));
      notifyListeners();
    }
  }
}
