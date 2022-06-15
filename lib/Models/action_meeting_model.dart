import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/meeting_model.dart';

class ActionMeetingDataModel {
  ActionMeetingDataModel({this.data});
  List<ActionMeetingModel>? data;
  factory ActionMeetingDataModel.fromJson(Map<String, dynamic> json) {
    return ActionMeetingDataModel(
      data: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List)
              .map((e) => ActionMeetingModel.fromJson(e))
              .toList(),
    );
  }
}
class ShortActionMeetingModel {
  ShortActionMeetingModel({this.data1, this.meeting});
  List<ActionMeetingModel>? data1;
  MeetingModel? meeting;
  factory ShortActionMeetingModel.fromJson(Map<String, dynamic> json) {
    return ShortActionMeetingModel(
      data1: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => ActionMeetingModel.fromJson(e)).toList(),
      meeting: json['data.meeting'] == null
          ? null
          : MeetingModel.fromJson(json['data.meeting']),
    );
  }
}

class ActionMeetingModel {
  String? sId;
  String? title;
  String? note;
  String? startDate;
  String? endDate;
  String? repeat;
  String? endRepeat;
  String? location;
  String? priority;
  bool? reminder;
  double? progress;
  String? todoImage;
  String? updatedDate;
  bool? mark;
  String? folderId;
  String? userId;
  var assignTo;

  ActionMeetingModel(
      {this.sId,
      this.title,
      this.note,
      this.startDate,
      this.endDate,
      this.repeat,
      this.endRepeat,
      this.location,
      this.priority,
      this.reminder,
      this.progress,
      this.todoImage,
      this.updatedDate,
      this.mark,
      this.folderId,
      this.userId,
      this.assignTo
      });

  ActionMeetingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    note = json['note'] ?? "N/A";
    startDate = json['startDate'] ?? "N/A";
    endDate = json['endDate'] ?? "N/A";
    repeat = json['repeat'] ?? "N/A";
    endRepeat = json['endRepeat'] ?? "N/A";
    location = json['location'] ?? "N/A";
    priority = json['priority'] ?? "N/A";
    reminder = json['reminder'] ?? "N/A";
    progress = json['progress'] ?? "N/A";
    todoImage = json['todoImage'] ?? "N/A";
    updatedDate = json['updatedDate'] ?? "N/A";
    mark = json['mark'];
    folderId = json['folderId'];
    userId = json['userId'];
    assignTo = (json["assignTo"] != null) ? ContactModel.fromJson(json['assignTo']) : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['repeat'] = this.repeat;
    data['endRepeat'] = this.endRepeat;
    data['location'] = this.location;
    data['priority'] = this.priority;
    data['reminder'] = this.reminder;
    data['progress'] = this.progress;
    data['todoImage'] = this.todoImage;
    data['updatedDate'] = this.updatedDate;
    data['mark'] = this.mark;
    data['folderId'] = this.folderId;
    data['userId'] = this.userId;
    return data;
  }
}
