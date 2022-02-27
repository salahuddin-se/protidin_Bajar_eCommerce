class SingleProduct {
  SingleProduct({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  SingleProduct.fromJson(Map<String, dynamic> json) {
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
    required this.addedBy,
    required this.sellerId,
    required this.erpId,
    required this.shopId,
    required this.shopName,
    required this.shopLogo,
    required this.photos,
    required this.thumbnailImage,
    required this.tags,
    required this.priceHighLow,
    required this.choiceOptions,
    required this.colors,
    required this.hasDiscount,
    required this.basePrice,
    required this.baseDiscountedPrice,
    required this.calculablePrice,
    required this.currencySymbol,
    required this.currentStock,
    required this.unit,
    required this.rating,
    required this.ratingCount,
    required this.earnPoint,
    this.description,
  });
  late final int id;
  late final String name;
  late final String addedBy;
  late final int sellerId;
  late final String erpId;
  late final int shopId;
  late final String shopName;
  late final String shopLogo;
  late final List<String> photos;
  late final String thumbnailImage;
  late final List<String> tags;
  late final String priceHighLow;
  late final List<dynamic> choiceOptions;
  late final List<dynamic> colors;
  late final bool hasDiscount;
  late final String basePrice;
  late final String baseDiscountedPrice;
  late final int calculablePrice;
  late final String currencySymbol;
  late final int currentStock;
  late final String unit;
  late final int rating;
  late final int ratingCount;
  late final int earnPoint;
  late final Null description;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addedBy = json['added_by'];
    sellerId = json['seller_id'];
    erpId = json['erp_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    photos = List.castFrom<dynamic, String>(json['photos']);
    thumbnailImage = json['thumbnail_image'];
    tags = List.castFrom<dynamic, String>(json['tags']);
    priceHighLow = json['price_high_low'];
    choiceOptions = List.castFrom<dynamic, dynamic>(json['choice_options']);
    colors = List.castFrom<dynamic, dynamic>(json['colors']);
    hasDiscount = json['has_discount'];
    basePrice = json['base_price'];
    baseDiscountedPrice = json['base_discounted_price'];
    calculablePrice = json['calculable_price'];
    currencySymbol = json['currency_symbol'];
    currentStock = json['current_stock'];
    unit = json['unit'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    earnPoint = json['earn_point'];
    description = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['added_by'] = addedBy;
    _data['seller_id'] = sellerId;
    _data['erp_id'] = erpId;
    _data['shop_id'] = shopId;
    _data['shop_name'] = shopName;
    _data['shop_logo'] = shopLogo;
    _data['photos'] = photos;
    _data['thumbnail_image'] = thumbnailImage;
    _data['tags'] = tags;
    _data['price_high_low'] = priceHighLow;
    _data['choice_options'] = choiceOptions;
    _data['colors'] = colors;
    _data['has_discount'] = hasDiscount;
    _data['base_price'] = basePrice;
    _data['base_discounted_price'] = baseDiscountedPrice;
    _data['calculable_price'] = calculablePrice;
    _data['currency_symbol'] = currencySymbol;
    _data['current_stock'] = currentStock;
    _data['unit'] = unit;
    _data['rating'] = rating;
    _data['rating_count'] = ratingCount;
    _data['earn_point'] = earnPoint;
    _data['description'] = description;
    return _data;
  }
}
