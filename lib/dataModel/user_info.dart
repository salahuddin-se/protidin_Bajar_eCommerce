class UserInfoModel {
  UserInfoModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  UserInfoModel.fromJson(Map<String, dynamic> json) {
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
    required this.name,
    required this.type,
    this.email,
    this.avatar,
    required this.avatarOriginal,
    this.address,
    this.city,
    this.country,
    this.postalCode,
    required this.phone,
  });

  late final int id;
  late final String name;
  late final String type;
  late final dynamic email;
  late final dynamic avatar;
  late final String avatarOriginal;
  late final dynamic address;
  late final dynamic city;
  late final dynamic country;
  late final dynamic postalCode;
  late final String? phone;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    email = null;
    avatar = null;
    avatarOriginal = json['avatar_original'];
    address = null;
    city = null;
    country = null;
    postalCode = null;
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['avatar_original'] = avatarOriginal;
    _data['address'] = address;
    _data['city'] = city;
    _data['country'] = country;
    _data['postal_code'] = postalCode;
    _data['phone'] = phone;
    return _data;
  }
}
