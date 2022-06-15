class PlanningDataModel {
  PlanningDataModel({this.data, this.totalPages, this.totalDocs});
  List<PlanningModel>? data;
  int? totalPages;
  int? totalDocs;

  factory PlanningDataModel.fromJson(Map<String, dynamic> json) {
    return PlanningDataModel(
      data: json['data']['docs'] == null || json['data']['docs'] == []
          ? []
          : (json['data']['docs'] as List)
              .map((e) => PlanningModel.fromJson(e))
              .toList(),
      totalPages: json['data']['totalPages'] == null
          ? null
          : json['data']['totalPages'],
      totalDocs: json['data']['totalDocs'] == null
          ? null
          :json['data']['totalDocs']
    );
  }
}

class PlanningModel {
  String? sId;
  String? title;
  String? note;
  String? startDate;
  String? endDate;
  String? location;
  bool? reminder;
  double? progress;
  // String? tripImage;
  String? updatedDate;
  bool? mark;
  String? userId;
  int? member;

  PlanningModel(
      {this.sId,
      this.title,
      this.note,
      this.startDate,
      this.endDate,
      this.location,
      this.reminder,
      this.progress,
      // this.tripImage,
      this.updatedDate,
      this.mark,
      this.userId,
      this.member});

  PlanningModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    note = json['note'] ?? "N/A";
    startDate = json['startDate'] ?? "N/A";
    endDate = json['endDate'] ?? "N/A";
    location = json['location'] ?? "N/A";
    reminder = json['reminder'] ?? "N/A";
    progress = json['progress'] ?? "N/A";
    // tripImage = json['tripImage'] ?? "N/A";
    updatedDate = json['updatedDate'] ?? "N/A";
    userId = json['userId'];
    member = json['member'] ?? 0;
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
    // data['tripImage'] = this.tripImage;
    data['updatedDate'] = this.updatedDate;
    data['mark'] = this.mark;
    data['userId'] = this.userId;
    data['member'] = this.member;
    return data;
  }
}
