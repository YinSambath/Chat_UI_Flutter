// import 'package:mcircle_project_ui/Models/meta_data_model.dart';

class ContactDataModel {
  ContactDataModel({this.data});
  List<ContactModel>? data;

  factory ContactDataModel.fromJson(Map<String, dynamic> json) {
    return ContactDataModel(
      data: json['data']['docs'] == null || json['data']['docs'] == []
          ? []
          : (json['data']['docs'] as List)
              .map((e) => ContactModel.fromJson(e))
              .toList(),
    );
  }
}

class ContactModel {
  String? email;
  String? sId;
  String? phone;
  String? firstname;
  String? lastname;
  bool? isTripCheck;
  // String? firstLetter;
  // String? lastLetter;
  ContactModel({
    this.sId,
    this.firstname,
    this.lastname,
    this.email,
    required this.phone,
    this.isTripCheck = false,
    // this.firstLetter = "M",
    // this.lastLetter = "C"
  });
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      sId: json["_id"],
      firstname: json['firstname'] ?? "",
      lastname: json['lastname'] ?? "",
      phone: json['phone'],
      email: json['email'] ?? "",
    );
  }

  static listContacts(dynamic json) =>
      (json as List).map((e) => ContactModel.fromJson(e)).toList();
}
