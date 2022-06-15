import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/config_route.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/todo_model.dart';

class TodoProvider with ChangeNotifier {
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

  TodoDataModel? _todoData;
  TodoDataModel? get todoData => _todoData;


  _setTodoData(TodoDataModel data) {
    _todoData = data;
    _setState(NotifierState.loaded);
  }

  ShortTodoModel? _shortData;
  ShortTodoModel? get shortData => _shortData;

  
  _setShortData(ShortTodoModel dataShort) {
    _shortData = dataShort;
    _setState(NotifierState.loaded);
  }

  void getTodoData(String sId, int page) async {
    _setState(NotifierState.loading);
    listTodo(sId, page).then((value) {
      if (_todoData != "") {
        _setTodoData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void createUpdate(TodoModel data) {
    if (_todoData != null && _todoData!.data!.isNotEmpty) {
      int _index =
          _todoData!.data!.indexWhere((element) => element.sId == data.sId);
      if (_index != -1) {
        _todoData!.data![_index] = data;
        notifyListeners();
      } else {
        if (_todoData!.totalDocs! % 10 == 0) {
          _todoData!.totalPages = _todoData!.totalPages! + 1;
        }
        _todoData!.data!.insert(0, data);
        notifyListeners();
      }
    }
    if (_todoData != null && _todoData!.data!.isEmpty) {
      _todoData!.data!.insert(0, data);
      notifyListeners();
    }
    if (_todoData == null) {
      _setTodoData(TodoDataModel(data: [data]));
      notifyListeners();
    }
  }

  void getSearchTodo(String search, String folderId) async {
    _setState(NotifierState.loading);
    searchTodo(search, folderId).then((value) {
      if (_todoData != "") {
        _setTodoData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }

  void getShortData() {
    _setState(NotifierState.loading);
    shortTodo().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
  void shortAllData() {
    _setState(NotifierState.loading);
    shortAllTodo().then((value) {
      if (_shortData != "") {
        _setShortData(value);
      } else {
        _setState(NotifierState.loaded);
      }
    });
  }
}
