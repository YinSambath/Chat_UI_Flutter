class UserDataModel {
  UserDataModel({this.data});
  List<UserModel>? data;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      data: json['data'] == null || json['data'] == []
          ? []
          : (json['data'] as List).map((e) => UserModel.fromJson(e)).toList(),
    );
  }
}

class UserModel {
  String? email;
  String? sId;
  String? phone;
  String? firstname;
  String? lastname;
  String? username;
  String? password;
  String? comfirmedPassword;
  String? token;
  String? refreshToken;
  String? resetLink;
  String? userProfile;
  String? dob;
  String? nationality;
  String? status;
  String? gender;
  String? website;
  String? address;

  UserModel({
    this.sId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.password,
    required this.comfirmedPassword,
    required this.token,
    required this.refreshToken,
    this.resetLink,
    required this.phone,
    this.userProfile,
    this.dob,
    this.address,
    this.gender,
    this.nationality,
    this.status,
    this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      sId: json["_id"],
      firstname: json['firstname'],
      lastname: json['lastname'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'] ?? "N/A",
      password: json['password'],
      resetLink: json['resetLink'] ?? "",
      refreshToken: json['refreshToken'],
      comfirmedPassword: json['comfirmedPassword'],
      token: json['token'],
      userProfile: json['userProfile'] ?? "",
      dob: json['dob'] ?? "N/A",
      address: json['address'] ?? "N/A",
      gender: json['gender'] ?? "N/A",
      nationality: json['nationality'] ?? "N/A",
      status: json['status'] ?? "N/A",
      website: json['website'] ?? "N/A",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': this.sId,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'username': this.username,
      'phone': this.phone,
      'email': this.email,
      'password': this.password,
      'resetLink': this.resetLink,
      'comfirmedPassword': this.comfirmedPassword,
      'token': this.token,
      'userProfile': this.userProfile,
      'dob': this.dob,
      'gender': this.gender,
      'address': this.address,
      'nationality': this.nationality,
      'status': this.status,
      'website': this.website,
    };
  }
}
