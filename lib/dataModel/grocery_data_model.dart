class Grocery {
  Grocery({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  Grocery.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['success'] = success;
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.logo,
    required this.links,
  });
  late final int id;
  late final String name;
  late final String logo;
  late final Links links;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    _data['links'] = links.toJson();
    return _data;
  }
}

class Links {
  Links({
    required this.products,
  });
  late final String products;

  Links.fromJson(Map<String, dynamic> json){
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products;
    return _data;
  }
}