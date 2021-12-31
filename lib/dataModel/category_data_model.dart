class CategoryDataModel {
  CategoryDataModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  CategoryDataModel.fromJson(Map<String, dynamic> json){
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
    required this.largeBanner,
    required this.mobileBanner,
    required this.icon,
    required this.numberOfChildren,
    required this.links,
  });
  late final int id;
  late final String name;
  late final String? largeBanner;
  late final String? mobileBanner;
  late final String? icon;
  late final int? numberOfChildren;
  late final Links links;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    largeBanner = json['large_banner'];
    mobileBanner = json['mobile_banner'];
    icon = json['icon'];
    numberOfChildren = json['number_of_children'];
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['large_banner'] = largeBanner;
    _data['mobile_banner'] = mobileBanner;
    _data['icon'] = icon;
    _data['number_of_children'] = numberOfChildren;
    _data['links'] = links.toJson();
    return _data;
  }
}

class Links {
  Links({
    required this.products,
    required this.subCategories,
  });
  late final String? products;
  late final String? subCategories;

  Links.fromJson(Map<String, dynamic> json){
    products = json['products'];
    subCategories = json['sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products;
    _data['sub_categories'] = subCategories;
    return _data;
  }
}

/*class CategoryDataModel {
  CategoryDataModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  CategoryDataModel.fromJson(Map<String, dynamic> json){
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
    required this.banner,
    required this.icon,
    required this.numberOfChildren,
    required this.links,
  });
  late final int id;
  late final String name;
  late final String banner;
  late final String icon;
  late final int numberOfChildren;
  late final Links links;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    banner = json['banner'];
    icon = json['icon'];
    numberOfChildren = json['number_of_children'];
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['banner'] = banner;
    _data['icon'] = icon;
    _data['number_of_children'] = numberOfChildren;
    _data['links'] = links.toJson();
    return _data;
  }
}

class Links {
  Links({
    required this.products,
    required this.subCategories,
  });
  late final String products;
  late final String subCategories;

  Links.fromJson(Map<String, dynamic> json){
    products = json['products'];
    subCategories = json['sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products;
    _data['sub_categories'] = subCategories;
    return _data;
  }
}*/