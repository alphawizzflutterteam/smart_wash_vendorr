// To parse this JSON data, do
//
//     final getDriverModel = getDriverModelFromJson(jsonString);

import 'dart:convert';

GetDriverModel getDriverModelFromJson(String str) => GetDriverModel.fromJson(json.decode(str));

String getDriverModelToJson(GetDriverModel data) => json.encode(data.toJson());

class GetDriverModel {
  String message;
  Data data;

  GetDriverModel({
    required this.message,
    required this.data,
  });

  factory GetDriverModel.fromJson(Map<String, dynamic> json) => GetDriverModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Order> order;

  Data({
    required this.order,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": List<dynamic>.from(order.map((x) => x.toJson())),
  };
}

class Order {
  int id;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  int isApprove;
  String firstName;
  String lastName;
  String mobile;
  String email;
  dynamic emailVerifiedAt;
  DateTime mobileVerifiedAt;
  int isActive;
  String password;
  dynamic profilePhotoId;
  dynamic gender;
  dynamic address;
  dynamic serviceP;
  String? services;
  dynamic alternativePhone;
  dynamic rememberToken;
  dynamic drivingLience;
  dynamic dateOfBirth;

  Order({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.isApprove,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.emailVerifiedAt,
    required this.mobileVerifiedAt,
    required this.isActive,
    required this.password,
    required this.profilePhotoId,
    required this.gender,
    required this.address,
    required this.serviceP,
    required this.services,
    required this.alternativePhone,
    required this.rememberToken,
    required this.drivingLience,
    required this.dateOfBirth,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isApprove: json["is_approve"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    mobileVerifiedAt: DateTime.parse(json["mobile_verified_at"]),
    isActive: json["is_active"],
    password: json["password"],
    profilePhotoId: json["profile_photo_id"],
    gender: json["gender"],
    address: json["address"],
    serviceP: json["service_p"],
    services: json["services"],
    alternativePhone: json["alternative_phone"],
    rememberToken: json["remember_token"],
    drivingLience: json["driving_lience"],
    dateOfBirth: json["date_of_birth"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_approve": isApprove,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "mobile_verified_at": mobileVerifiedAt.toIso8601String(),
    "is_active": isActive,
    "password": password,
    "profile_photo_id": profilePhotoId,
    "gender": gender,
    "address": address,
    "service_p": serviceP,
    "services": services,
    "alternative_phone": alternativePhone,
    "remember_token": rememberToken,
    "driving_lience": drivingLience,
    "date_of_birth": dateOfBirth,
  };
}
