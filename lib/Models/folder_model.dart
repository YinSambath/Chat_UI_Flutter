// import 'package:mcircle_project_ui/Models/meta_data_model.dart';

class FolderDataModel {
  FolderDataModel({this.data});
  List<FolderModel>? data;

  factory FolderDataModel.fromJson(Map<String, dynamic> json) {
    return FolderDataModel(
      data: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => FolderModel.fromJson(e)).toList(),
    );
  }
}

class FolderModel {
  String? name;
  String? sId;

  FolderModel({
    this.sId,
    required this.name,
  });
  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      sId: json["_id"],
      name: json['name'] ?? "",
    );
  }

  static listContacts(dynamic json) =>
      (json as List).map((e) => FolderModel.fromJson(e)).toList();
}
