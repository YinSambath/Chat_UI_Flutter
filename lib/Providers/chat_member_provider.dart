import 'dart:convert';

import 'package:mcircle_project_ui/Configs/enum.dart';
import 'package:mcircle_project_ui/Models/message.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class ChatMemberProvider extends ChangeNotifier {
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

  ChatDataModel? _chatData;
  ChatDataModel? get chatData => _chatData;

  _setChatData(ChatDataModel data) {
    _chatData = data;
    _setState(NotifierState.loaded);
  }

  void getChatData() async {
    _setState(NotifierState.loading);
    listChat().then((value) {
      _setChatData(value);
      _setState(NotifierState.loaded);
      if (_chatData != null) {
      } else {}
    });
  }
}
