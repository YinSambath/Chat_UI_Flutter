import 'package:mcircle_project_ui/Models/contact_model.dart';

class ActionPlanningDataModel {
  ActionPlanningDataModel({this.data, this.totalPages});
  List<ActionPlanningModel>? data;
  int? totalPages;
  factory ActionPlanningDataModel.fromJson(Map<String, dynamic> json) {
    return ActionPlanningDataModel(
      data: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List)
              .map((e) => ActionPlanningModel.fromJson(e))
              .toList(),
    );
  }
}
class ShortActionPlanningModel {
  ShortActionPlanningModel({this.data1});
  List<ActionPlanningModel>? data1;
  factory ShortActionPlanningModel.fromJson(Map<String, dynamic> json) {
    return ShortActionPlanningModel(
      data1: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => ActionPlanningModel.fromJson(e)).toList(),
      
    );
  }
}

class ActionPlanningModel {
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

  ActionPlanningModel(
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
      this.assignTo,
      });

  ActionPlanningModel.fromJson(Map<String, dynamic> json) {
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
    // planning = (json['planning'] != null) ? PlanningModel.fromJson(json['planning']):"";
    assignTo = json["assignTo"] != null ? ContactModel.fromJson(json['assignTo']) : "";
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
