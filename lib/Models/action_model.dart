import 'package:mcircle_project_ui/Models/contact_model.dart';
import 'package:mcircle_project_ui/Models/trip_model.dart';

class ActionDataModel {
  ActionDataModel({this.data});
  List<ActionModel>? data;

  factory ActionDataModel.fromJson(Map<String, dynamic> json) {
    return ActionDataModel(
      data: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => ActionModel.fromJson(e)).toList(),
    );
  }
}
class ShortActionModel {
  ShortActionModel({this.data1, this.trip});
  List<ActionModel>? data1;
  TripModel? trip;
  factory ShortActionModel.fromJson(Map<String, dynamic> json) {
    return ShortActionModel(
      data1: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => ActionModel.fromJson(e)).toList(),
      trip: json['data.trip'] == null
          ? null
          : TripModel.fromJson(json['data.trip']),
    );
  }
}

class ActionModel {
  String? sId;
  String? title;
  String? note;
  String? startDate;
  String? endDate;
  String? location;
  bool? reminder;
  double? progress;
  String? tripActionImage;
  String? updatedDate;
  bool? mark;
  int? member;
  String? tripId;
  var assignTo;

  ActionModel({
    this.sId,
    this.title,
    this.note,
    this.startDate,
    this.endDate,
    this.location,
    this.reminder,
    this.progress,
    this.tripActionImage,
    this.updatedDate,
    this.mark,
    this.member,
    this.tripId,
    this.assignTo
  });

  ActionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    note = json['note'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    location = json['location'];
    reminder = json['reminder'];
    progress = json['progress'];
    tripActionImage = json['tripActionImage'];
    updatedDate = json['updatedDate'];
    mark = json['mark'];
    member = json['member'];
    tripId = json['tripId'];
    assignTo = (json["assignTo"] != null) ? ContactModel.fromJson(json['assignTo']) : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['location'] = this.location;
    data['reminder'] = this.reminder;
    data['progress'] = this.progress;
    data['tripActionImage'] = this.tripActionImage;
    data['updatedDate'] = this.updatedDate;
    data['mark'] = this.mark;
    data['member'] = this.member;
    data['tripId'] = this.tripId;
    return data;
  }
}
