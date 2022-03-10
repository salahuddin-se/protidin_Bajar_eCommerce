class CityModel {
  CityModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<City> data;
  late final bool success;
  late final int status;

  CityModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => City.fromJson(e)).toList();
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

class City {
  City({
    required this.id,
    required this.countryId,
    required this.name,
    required this.cityId,
    required this.area,
    required this.cost,
  });
  late final int id;
  late final int countryId;
  late final String name;
  late final int cityId;
  late final String area;
  late final int cost;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    cityId = json['city_id'];
    area = json['area'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['country_id'] = countryId;
    _data['name'] = name;
    _data['city_id'] = cityId;
    _data['area'] = area;
    _data['cost'] = cost;
    return _data;
  }
}
