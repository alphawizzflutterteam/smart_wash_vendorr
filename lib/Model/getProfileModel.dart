/// message : "Profile is updated successfully"
/// data : {"user":{"id":52,"first_name":"raftar","last_name":"kumar","name":"raftar kumar","email":"raf@gmail.com","mobile":"8870707070","gender":"Female","services":[{"id":1,"name":"Shoe Cleaning","name_bn":null,"description":"Cumque repudiandae perspiciatis inventore. Sapiente id enim id hic et cumque eos ut.","description_bn":null,"thumbnail_id":4,"is_active":1,"created_at":"2023-07-12T08:06:09.000000Z","updated_at":"2023-08-21T12:55:21.000000Z"},{"id":2,"name":"Dry Clean","name_bn":null,"description":"Fugit corporis qui enim doloremque quia. Ipsum et illo quidem voluptatibus eligendi recusandae iusto. Unde rerum provident et ex est.","description_bn":null,"thumbnail_id":5,"is_active":1,"created_at":"2023-07-12T08:06:09.000000Z","updated_at":"2023-08-29T06:51:07.000000Z"}],"service_p":2,"address":"testingadd","mobile_verified_at":"2023-08-31T07:25:12.000000Z","is_active":true,"alternative_phone":null,"profile_photo_path":"http://laundry.developmentalphawizz.com/images/dummy/dummy-user.png","driving_lience":null,"date_of_birth":"10 August, 1990","join_date":"31 August, 2023"}}

class GetProfileModel {
  GetProfileModel({
      String? message, 
      Data? data,}){
    _message = message;
    _data = data;
}

  GetProfileModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  Data? _data;
GetProfileModel copyWith({  String? message,
  Data? data,
}) => GetProfileModel(  message: message ?? _message,
  data: data ?? _data,
);
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}


class Data {
  Data({
      User? user,}){
    _user = user;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;
Data copyWith({  User? user,
}) => Data(  user: user ?? _user,
);
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 52
/// first_name : "raftar"
/// last_name : "kumar"
/// name : "raftar kumar"
/// email : "raf@gmail.com"
/// mobile : "8870707070"
/// gender : "Female"
/// services : [{"id":1,"name":"Shoe Cleaning","name_bn":null,"description":"Cumque repudiandae perspiciatis inventore. Sapiente id enim id hic et cumque eos ut.","description_bn":null,"thumbnail_id":4,"is_active":1,"created_at":"2023-07-12T08:06:09.000000Z","updated_at":"2023-08-21T12:55:21.000000Z"},{"id":2,"name":"Dry Clean","name_bn":null,"description":"Fugit corporis qui enim doloremque quia. Ipsum et illo quidem voluptatibus eligendi recusandae iusto. Unde rerum provident et ex est.","description_bn":null,"thumbnail_id":5,"is_active":1,"created_at":"2023-07-12T08:06:09.000000Z","updated_at":"2023-08-29T06:51:07.000000Z"}]
/// service_p : 2
/// address : "testingadd"
/// mobile_verified_at : "2023-08-31T07:25:12.000000Z"
/// is_active : true
/// alternative_phone : null
/// profile_photo_path : "http://laundry.developmentalphawizz.com/images/dummy/dummy-user.png"
/// driving_lience : null
/// date_of_birth : "10 August, 1990"
/// join_date : "31 August, 2023"

class User {
  User({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? name, 
      String? email, 
      String? mobile, 
      String? gender, 
      List<Services>? services,
    String? serviceP,
      String? address, 
      String? mobileVerifiedAt, 
      bool? isActive, 
      dynamic alternativePhone, 
      String? profilePhotoPath, 
      dynamic drivingLience, 
      String? dateOfBirth, 
      String? joinDate,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _name = name;
    _email = email;
    _mobile = mobile;
    _gender = gender;
    _services = services;
    _serviceP = serviceP;
    _address = address;
    _mobileVerifiedAt = mobileVerifiedAt;
    _isActive = isActive;
    _alternativePhone = alternativePhone;
    _profilePhotoPath = profilePhotoPath;
    _drivingLience = drivingLience;
    _dateOfBirth = dateOfBirth;
    _joinDate = joinDate;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _gender = json['gender'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
    _serviceP = json['service_p'];
    _address = json['address'];
    _mobileVerifiedAt = json['mobile_verified_at'];
    _isActive = json['is_active'];
    _alternativePhone = json['alternative_phone'];
    _profilePhotoPath = json['profile_photo_path'];
    _drivingLience = json['driving_lience'];
    _dateOfBirth = json['date_of_birth'];
    _joinDate = json['join_date'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _name;
  String? _email;
  String? _mobile;
  String? _gender;
  List<Services>? _services;
  String? _serviceP;
  String? _address;
  String? _mobileVerifiedAt;
  bool? _isActive;
  dynamic _alternativePhone;
  String? _profilePhotoPath;
  dynamic _drivingLience;
  String? _dateOfBirth;
  String? _joinDate;
User copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? name,
  String? email,
  String? mobile,
  String? gender,
  List<Services>? services,
  String? serviceP,
  String? address,
  String? mobileVerifiedAt,
  bool? isActive,
  dynamic alternativePhone,
  String? profilePhotoPath,
  dynamic drivingLience,
  String? dateOfBirth,
  String? joinDate,
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  name: name ?? _name,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  gender: gender ?? _gender,
  services: services ?? _services,
  serviceP: serviceP ?? _serviceP,
  address: address ?? _address,
  mobileVerifiedAt: mobileVerifiedAt ?? _mobileVerifiedAt,
  isActive: isActive ?? _isActive,
  alternativePhone: alternativePhone ?? _alternativePhone,
  profilePhotoPath: profilePhotoPath ?? _profilePhotoPath,
  drivingLience: drivingLience ?? _drivingLience,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  joinDate: joinDate ?? _joinDate,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get gender => _gender;
  List<Services>? get services => _services;
  String? get serviceP => _serviceP;
  String? get address => _address;
  String? get mobileVerifiedAt => _mobileVerifiedAt;
  bool? get isActive => _isActive;
  dynamic get alternativePhone => _alternativePhone;
  String? get profilePhotoPath => _profilePhotoPath;
  dynamic get drivingLience => _drivingLience;
  String? get dateOfBirth => _dateOfBirth;
  String? get joinDate => _joinDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['gender'] = _gender;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    map['service_p'] = _serviceP;
    map['address'] = _address;
    map['mobile_verified_at'] = _mobileVerifiedAt;
    map['is_active'] = _isActive;
    map['alternative_phone'] = _alternativePhone;
    map['profile_photo_path'] = _profilePhotoPath;
    map['driving_lience'] = _drivingLience;
    map['date_of_birth'] = _dateOfBirth;
    map['join_date'] = _joinDate;
    return map;
  }

}

/// id : 1
/// name : "Shoe Cleaning"
/// name_bn : null
/// description : "Cumque repudiandae perspiciatis inventore. Sapiente id enim id hic et cumque eos ut."
/// description_bn : null
/// thumbnail_id : 4
/// is_active : 1
/// created_at : "2023-07-12T08:06:09.000000Z"
/// updated_at : "2023-08-21T12:55:21.000000Z"

class Services {
  Services({
      num? id, 
      String? name, 
      dynamic nameBn, 
      String? description, 
      dynamic descriptionBn, 
      num? thumbnailId, 
      num? isActive, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _nameBn = nameBn;
    _description = description;
    _descriptionBn = descriptionBn;
    _thumbnailId = thumbnailId;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameBn = json['name_bn'];
    _description = json['description'];
    _descriptionBn = json['description_bn'];
    _thumbnailId = json['thumbnail_id'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  dynamic _nameBn;
  String? _description;
  dynamic _descriptionBn;
  num? _thumbnailId;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
Services copyWith({  num? id,
  String? name,
  dynamic nameBn,
  String? description,
  dynamic descriptionBn,
  num? thumbnailId,
  num? isActive,
  String? createdAt,
  String? updatedAt,
}) => Services(  id: id ?? _id,
  name: name ?? _name,
  nameBn: nameBn ?? _nameBn,
  description: description ?? _description,
  descriptionBn: descriptionBn ?? _descriptionBn,
  thumbnailId: thumbnailId ?? _thumbnailId,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  dynamic get nameBn => _nameBn;
  String? get description => _description;
  dynamic get descriptionBn => _descriptionBn;
  num? get thumbnailId => _thumbnailId;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['name_bn'] = _nameBn;
    map['description'] = _description;
    map['description_bn'] = _descriptionBn;
    map['thumbnail_id'] = _thumbnailId;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}