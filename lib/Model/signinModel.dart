// To parse this JSON data, do
//
//     final signinModel = signinModelFromJson(jsonString);

import 'dart:convert';

SigninModel signinModelFromJson(String str) => SigninModel.fromJson(json.decode(str));

String signinModelToJson(SigninModel data) => json.encode(data.toJson());

class SigninModel {
  String message;
  Data data;

  SigninModel({
    required this.message,
    required this.data,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) => SigninModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  User user;
  Access access;

  Data({
    required this.user,
    required this.access,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    access: Access.fromJson(json["access"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access": access.toJson(),
  };
}

class Access {
  String authType;
  String token;
  DateTime expiresAt;

  Access({
    required this.authType,
    required this.token,
    required this.expiresAt,
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
    authType: json["auth_type"],
    token: json["token"],
    expiresAt: DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "auth_type": authType,
    "token": token,
    "expires_at": expiresAt.toIso8601String(),
  };
}

class User {
  String id;
  String firstName;
  String lastName;
  String name;
  String email;
  String mobile;
  String gender;
  List<Service> services;
  String serviceP;
  String address;
  String mobileVerifiedAt;
  String isActive;
  String alternativePhone;
  String profilePhotoPath;
  String drivingLience;
  String dateOfBirth;
  String joinDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.services,
    required this.serviceP,
    required this.address,
    required this.mobileVerifiedAt,
    required this.isActive,
    required this.alternativePhone,
    required this.profilePhotoPath,
    required this.drivingLience,
    required this.dateOfBirth,
    required this.joinDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"].toString(),
    firstName: json["first_name"].toString(),
    lastName: json["last_name"].toString(),
    name: json["name"].toString(),
    email: json["email"].toString(),
    mobile: json["mobile"].toString(),
    gender: json["gender"].toString(),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    serviceP: json["service_p"].toString(),
    address: json["address"].toString(),
    mobileVerifiedAt: json["mobile_verified_at"].toString(),
    isActive: json["is_active"].toString(),
    alternativePhone: json["alternative_phone"].toString(),
    profilePhotoPath: json["profile_photo_path"].toString(),
    drivingLience: json["driving_lience"].toString(),
    dateOfBirth: json["date_of_birth"].toString(),
    joinDate: json["join_date"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "email": email,
    "mobile": mobile,
    "gender": gender,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "service_p": serviceP,
    "address": address,
    "mobile_verified_at": mobileVerifiedAt,
    "is_active": isActive,
    "alternative_phone": alternativePhone,
    "profile_photo_path": profilePhotoPath,
    "driving_lience": drivingLience,
    "date_of_birth": dateOfBirth,
    "join_date": joinDate,
  };
}

class Service {
  String id;
  String name;
  String nameBn;
  String description;
  String descriptionBn;
  String thumbnailId;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String vendorId;

  Service({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.description,
    required this.descriptionBn,
    required this.thumbnailId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.vendorId,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"].toString(),
    name: json["name"].toString(),
    nameBn: json["name_bn"].toString(),
    description: json["description"].toString(),
    descriptionBn: json["description_bn"].toString(),
    thumbnailId: json["thumbnail_id"].toString(),
    isActive: json["is_active"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    vendorId: json["vendor_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_bn": nameBn,
    "description": description,
    "description_bn": descriptionBn,
    "thumbnail_id": thumbnailId,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "vendor_id": vendorId,
  };
}
