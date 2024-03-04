import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/message.dart';
import 'package:mcircle_project_ui/Perferrences/share_perfs.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class MessageProvider extends ChangeNotifier {
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

  ChatModel? _privatechat;
  ChatModel? get privatechat => _privatechat;

  _setprivateChatData(ChatModel data) {
    _privatechat = data;
    _setState(NotifierState.loaded);
  }

  // ChatDataModel? _chatData;
  // ChatDataModel? get chatData => _chatData;

  // _setChatData(ChatDataModel data) {
  //   _chatData = data;
  //   _setState(NotifierState.loaded);
  // }

  void getPrivateChatData(String person2Id) {
    _setState(NotifierState.loading);
    privateChat(person2Id).then((value) {
      _setprivateChatData(value);
      _setState(NotifierState.loaded);
    });
  }

  void addNewMessage(data) {
    print('data is not empty');
    _setprivateChatData(data);
    notifyListeners();
  }
}
