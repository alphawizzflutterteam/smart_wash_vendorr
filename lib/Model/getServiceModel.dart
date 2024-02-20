class GetServicesModel {
  String? message;
  Data? data;

  GetServicesModel({this.message, this.data});

  GetServicesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Service>? services;

  Data({this.services});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  String id;
  String name;
  String nameBn;
  String description;
  String descriptionBn;
  String imagePath;

  Service({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.description,
    required this.descriptionBn,
    required this.imagePath,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"].toString(),
    name: json["name"].toString(),
    nameBn: json["name_bn"].toString(),
    description: json["description"].toString(),
    descriptionBn: json["description_bn"].toString(),
    imagePath: json["image_path"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_bn": nameBn,
    "description": description,
    "description_bn": descriptionBn,
    "image_path": imagePath,
  };
}
