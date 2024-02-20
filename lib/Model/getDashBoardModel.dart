/// message : "dashboard Details"
/// data : {"customers":38,"services":2,"products":0,"income":0,"todayOrders":0}

class GetDashBoardModel {
  GetDashBoardModel({
      String? message, 
      Data? data,}){
    _message = message;
    _data = data;
}

  GetDashBoardModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  Data? _data;
GetDashBoardModel copyWith({  String? message,
  Data? data,
}) => GetDashBoardModel(  message: message ?? _message,
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

/// customers : 38
/// services : 2
/// products : 0
/// income : 0
/// todayOrders : 0

class Data {
  Data({
      num? customers, 
      num? services, 
      num? products, 
      num? income, 
      num? todayOrders,}){
    _customers = customers;
    _services = services;
    _products = products;
    _income = income;
    _todayOrders = todayOrders;
}

  Data.fromJson(dynamic json) {
    _customers = json['customers'];
    _services = json['services'];
    _products = json['products'];
    _income = json['income'];
    _todayOrders = json['todayOrders'];
  }
  num? _customers;
  num? _services;
  num? _products;
  num? _income;
  num? _todayOrders;
Data copyWith({  num? customers,
  num? services,
  num? products,
  num? income,
  num? todayOrders,
}) => Data(  customers: customers ?? _customers,
  services: services ?? _services,
  products: products ?? _products,
  income: income ?? _income,
  todayOrders: todayOrders ?? _todayOrders,
);
  num? get customers => _customers;
  num? get services => _services;
  num? get products => _products;
  num? get income => _income;
  num? get todayOrders => _todayOrders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customers'] = _customers;
    map['services'] = _services;
    map['products'] = _products;
    map['income'] = _income;
    map['todayOrders'] = _todayOrders;
    return map;
  }

}