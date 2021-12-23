class BiacuitSweets {
  BiacuitSweets({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });
  late final List<BuiscitData> data;
  late final Links links;
  late final Meta meta;
  late final bool success;
  late final int status;

  BiacuitSweets.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>BuiscitData.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['links'] = links.toJson();
    _data['meta'] = meta.toJson();
    _data['success'] = success;
    _data['status'] = status;
    return _data;
  }
}

class BuiscitData {
  BuiscitData({
    required this.id,
    required this.name,
    required this.shopName,
    required this.erpId,
    required this.thumbnailImage,
    required this.hasDiscount,
    required this.basePrice,
    required this.baseDiscountedPrice,
    required this.discount,
    required this.discountType,
    required this.rating,
    required this.sales,
    required this.unit,
    required this.links,
  });
  late final int id;
  late final String name;
  late final String shopName;
  late final String erpId;
  late final String thumbnailImage;
  late final bool hasDiscount;
  late final String basePrice;
  late final String baseDiscountedPrice;
  late final int? discount;
  late final String? discountType;
  late final int rating;
  late final int? sales;
  late final String unit;
  late final Links links;

  BuiscitData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    shopName = json['shop_name'];
    erpId = json['erp_id'];
    thumbnailImage = json['thumbnail_image'];
    hasDiscount = json['has_discount'];
    basePrice = json['base_price'];
    baseDiscountedPrice = json['base_discounted_price'];
    discount = json['discount'];
    discountType = json['discount_type'];
    rating = json['rating'];
    sales = json['sales'];
    unit = json['unit'];
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['shop_name'] = shopName;
    _data['erp_id'] = erpId;
    _data['thumbnail_image'] = thumbnailImage;
    _data['has_discount'] = hasDiscount;
    _data['base_price'] = basePrice;
    _data['base_discounted_price'] = baseDiscountedPrice;
    _data['discount'] = discount;
    _data['discount_type'] = discountType;
    _data['rating'] = rating;
    _data['sales'] = sales;
    _data['unit'] = unit;
    _data['links'] = links.toJson();
    return _data;
  }
}

class Links {
  Links({
    required this.details,
  });
  late final String? details;

  Links.fromJson(Map<String, dynamic> json){
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['details'] = details;
    return _data;
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Meta.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}