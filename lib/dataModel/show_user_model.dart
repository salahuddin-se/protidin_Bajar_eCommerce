class ShowUserAddressModel {
  ShowUserAddressModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  ShowUserAddressModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['success'] = success;
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.address,
    required this.country,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.setDefault,
  });

  late final int id;
  late final int userId;
  late final String address;
  late final String? country;
  late final String? city;
  late final String? postalCode;
  late final String? phone;
  late final int setDefault;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    setDefault = json['set_default'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['address'] = address;
    _data['country'] = country;
    _data['city'] = city;
    _data['postal_code'] = postalCode;
    _data['phone'] = phone;
    _data['set_default'] = setDefault;
    return _data;
  }
}

/*
class ShowUserAddressModel {
  ShowUserAddressModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  ShowUserAddressModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['success'] = success;
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.address,
    required this.country,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.setDefault,
  });

  late final int id;
  late final int userId;
  late final String address;
  late final String country;
  late final String city;
  late final String postalCode;
  late final String phone;
  late final int setDefault;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    setDefault = json['set_default'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['address'] = address;
    _data['country'] = country;
    _data['city'] = city;
    _data['postal_code'] = postalCode;
    _data['phone'] = phone;
    _data['set_default'] = setDefault;
    return _data;
  }
}

*/
