import 'package:mcircle_project_ui/Models/contact_model.dart';

class TripDataModel {
  TripDataModel({this.data, this.totalPages, this.totalDocs});
  List<TripModel>? data;
  int? totalPages;
  int? totalDocs;

  factory TripDataModel.fromJson(Map<String, dynamic> json) {
    return TripDataModel(
      data: json['data']['docs'] == null || json['data']['docs'] == []
          ? []
          : (json['data']['docs'] as List)
              .map((e) => TripModel.fromJson(e))
              .toList(),
      totalPages: json['data']['totalPages'] == null
          ? null
          : (json['data']['totalPages']),
      totalDocs: json['data']['totalDocs'] == null
          ? null
          :json['data']['totalDocs']
      
    );
  }
}

class TripModel {
  String? sId;
  String? title;
  String? note;
  String? startDate;
  String? endDate;
  double? lat;
  double? lng;
  String? location;
  bool? reminder;
  double? progress;
  String? tripImage;
  String? updatedDate;
  int? member;
  bool? mark;
  String? userId;
 
  TripModel(
      {this.sId,
      this.title,
      this.note,
      this.startDate,
      this.endDate,
      this.lat,
      this.lng,
      this.location,
      this.reminder,
      this.progress,
      this.tripImage,
      this.updatedDate,
      this.member,
      this.mark,
      this.userId});

  TripModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    note = json['note'] ?? "N/A";
    startDate = json['startDate'] ?? "N/A";
    endDate = json['endDate'] ?? "N/A";
    lat = json['lat'] ?? 11.5999389;
    lng = json['lng'] ?? 104.8853553;
    location = json['location'] ?? "N/A";
    reminder = json['reminder'] ?? "N/A";
    progress = json['progress'] ?? "N/A";
    tripImage = json['tripImage'] ?? "N/A";
    updatedDate = json['updatedDate'] ?? "N/A";
    member = json['member'] ?? 0;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    data['reminder'] = this.reminder;
    data['progress'] = this.progress;
    data['tripImage'] = this.tripImage;
    data['updatedDate'] = this.updatedDate;
    data['member'] = this.member;
    data['mark'] = this.mark;
    data['userId'] = this.userId;
    return data;
  }
}
