class CartDetailsModel {
  CartDetailsModel({
    required this.name,
    required this.ownerId,
    required this.cartItems,
  });
  late final String? name;
  late final int? ownerId;
  late final List<CartItems> cartItems;

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ownerId = json['owner_id'];
    cartItems = List.from(json['cart_items']).map((e) => CartItems.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['owner_id'] = ownerId;
    _data['cart_items'] = cartItems.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CartItems {
  CartItems({
    this.id,
    this.ownerId,
    this.userId,
    this.productId,
    this.productName,
    this.productThumbnailImage,
    this.variation,
    this.price,
    this.currencySymbol,
    this.tax,
    this.shippingCost,
    this.quantity,
    this.lowerLimit,
    this.upperLimit,
  });
  late final int? id;
  late final int? ownerId;
  late final int? userId;
  late final int? productId;
  late final String? productName;
  late final String? productThumbnailImage;
  late final dynamic variation;
  late final int? price;
  late final String? currencySymbol;
  late final int? tax;
  late final int? shippingCost;
  late int? quantity;
  late final int? lowerLimit;
  late final int? upperLimit;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productThumbnailImage = json['product_thumbnail_image'];
    variation = null;
    price = json['price'];
    currencySymbol = json['currency_symbol'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    lowerLimit = json['lower_limit'];
    upperLimit = json['upper_limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['owner_id'] = ownerId;
    _data['user_id'] = userId;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_thumbnail_image'] = productThumbnailImage;
    _data['variation'] = variation;
    _data['price'] = price;
    _data['currency_symbol'] = currencySymbol;
    _data['tax'] = tax;
    _data['shipping_cost'] = shippingCost;
    _data['quantity'] = quantity;
    _data['lower_limit'] = lowerLimit;
    _data['upper_limit'] = upperLimit;
    return _data;
  }
}
