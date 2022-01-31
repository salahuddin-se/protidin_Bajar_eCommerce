class PurchaseDetails {
  PurchaseDetails({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  PurchaseDetails.fromJson(Map<String, dynamic> json) {
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
    required this.product,
    this.variation,
    required this.price,
    required this.tax,
    required this.shippingCost,
    this.couponDiscount,
    required this.quantity,
    required this.paymentStatus,
    required this.deliveryStatus,
  });
  late final String product;
  late final dynamic? variation;
  late final int price;
  late final int tax;
  late final int shippingCost;
  late final dynamic? couponDiscount;
  late final int quantity;
  late final String paymentStatus;
  late final String deliveryStatus;

  Data.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    variation = null;
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    couponDiscount = null;
    quantity = json['quantity'];
    paymentStatus = json['payment_status'];
    deliveryStatus = json['delivery_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product;
    _data['variation'] = variation;
    _data['price'] = price;
    _data['tax'] = tax;
    _data['shipping_cost'] = shippingCost;
    _data['coupon_discount'] = couponDiscount;
    _data['quantity'] = quantity;
    _data['payment_status'] = paymentStatus;
    _data['delivery_status'] = deliveryStatus;
    return _data;
  }
}
