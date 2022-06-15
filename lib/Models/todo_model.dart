import 'package:mcircle_project_ui/Models/folder_model.dart';

class TodoDataModel {
  TodoDataModel({this.data, this.totalPages, this.totalDocs});
  List<TodoModel>? data;
  int? totalPages;
  int? totalDocs;

  factory TodoDataModel.fromJson(Map<String, dynamic> json) {
    return TodoDataModel(
      data: json['data']['docs'] == null || json['data']['docs'] == []
          ? []
          : (json['data']['docs'] as List)
              .map((e) => TodoModel.fromJson(e))
              .toList(),
      totalPages: json['data']['totalPages'] == null
          ? null
          : json['data']['totalPages'],
      totalDocs: json['data']['totalDocs'] == null 
          ? null 
          : json['data']['totalDocs']
    );
  }
}

class ShortTodoModel {
  ShortTodoModel({this.data1, this.folder});
  List<TodoModel>? data1;
  FolderModel? folder;
  factory ShortTodoModel.fromJson(Map<String, dynamic> json) {
    return ShortTodoModel(
      data1: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => TodoModel.fromJson(e)).toList(),
    );
  }
}

class TodoModel {
  String? sId;
  String? title;
  String? note;
  String? dateTime;
  String? repeat;
  String? endRepeat;
  String? location;
  String? priority;
  bool? reminder;
  double? progress;
  String? todoImage;
  // String? createdDate;
  String? updatedDate;
  bool? mark;
  String? folderId;
  String? userId;
  var folder;

  TodoModel(
      {this.sId,
      this.title,
      this.note,
      this.dateTime,
      this.repeat,
      this.endRepeat,
      this.location,
      this.priority,
      this.reminder,
      this.progress,
      this.todoImage,
      // this.createdDate,
      this.updatedDate,
      this.mark,
      this.folderId,
      this.userId,
      this.folder});

  TodoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "N/A";
    title = json['title'] ?? "N/A";
    note = json['note'] ?? "N/A";
    dateTime = json['dateTime'] ?? "N/A";
    repeat = json['repeat'] ?? "N/A";
    endRepeat = json['endRepeat'] ?? "N/A";
    location = json['location'] ?? "N/A";
    priority = json['priority'] ?? "N/A";
    reminder = json['reminder'] ?? "N/A";
    progress = json['progress'] ?? "N/A";
    todoImage = json['todoImage'] ?? "N/A";
    // createdDate = json['createdDate'] ?? "N/A";
    updatedDate = json['updatedDate'] ?? "N/A";
    mark = json['mark'] ?? "N/A";
    folderId = json['folderId'] ?? "N/A";
    userId = json['userId'] ?? "N/A";
    folder = (json["folder"] != null) ?FolderModel.fromJson(json['folder']) : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['dateTime'] = this.dateTime;
    data['repeat'] = this.repeat;
    data['endRepeat'] = this.endRepeat;
    data['location'] = this.location;
    data['priority'] = this.priority;
    data['reminder'] = this.reminder;
    data['progress'] = this.progress;
    data['todoImage'] = this.todoImage;
    // data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['mark'] = this.mark;
    data['folderId'] = this.folderId;
    data['userId'] = this.userId;
    return data;
  }
}
