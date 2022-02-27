// class PurchaseDetails {
//   PurchaseDetails({
//     required this.data,
//     required this.success,
//     required this.status,
//   });
//   late final List<Data> data;
//   late final bool success;
//   late final int status;
//
//   PurchaseDetails.fromJson(Map<String, dynamic> json) {
//     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
//     success = json['success'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     _data['success'] = success;
//     _data['status'] = status;
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.productId,
//     this.variation,
//     required this.price,
//     required this.tax,
//     required this.shippingCost,
//     this.couponDiscount,
//     required this.quantity,
//     required this.paymentStatus,
//     required this.deliveryStatus,
//   });
//   late final int productId;
//   late final dynamic? variation;
//   late final int price;
//   late final int tax;
//   late final int shippingCost;
//   late final dynamic? couponDiscount;
//   late final int quantity;
//   late final String paymentStatus;
//   late final String deliveryStatus;
//
//   Data.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     variation = null;
//     price = json['price'];
//     tax = json['tax'];
//     shippingCost = json['shipping_cost'];
//     couponDiscount = null;
//     quantity = json['quantity'];
//     paymentStatus = json['payment_status'];
//     deliveryStatus = json['delivery_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['variation'] = variation;
//     _data['price'] = price;
//     _data['tax'] = tax;
//     _data['shipping_cost'] = shippingCost;
//     _data['coupon_discount'] = couponDiscount;
//     _data['quantity'] = quantity;
//     _data['payment_status'] = paymentStatus;
//     _data['delivery_status'] = deliveryStatus;
//     return _data;
//   }
// }

class PurchaseHistoryItems {
  PurchaseHistoryItems({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  PurchaseHistoryItems.fromJson(Map<String, dynamic> json) {
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
    required this.productId,
    required this.productName,
    this.variation,
    required this.price,
    required this.tax,
    required this.shippingCost,
    required this.couponDiscount,
    required this.quantity,
    required this.paymentStatus,
    required this.paymentStatusString,
    required this.deliveryStatus,
    required this.deliveryStatusString,
  });
  late final int productId;
  late final String productName;
  late final Null variation;
  late final String price;
  late final String tax;
  late final String shippingCost;
  late final String couponDiscount;
  late final int quantity;
  late final String paymentStatus;
  late final String paymentStatusString;
  late final String deliveryStatus;
  late final String deliveryStatusString;

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    variation = null;
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    couponDiscount = json['coupon_discount'];
    quantity = json['quantity'];
    paymentStatus = json['payment_status'];
    paymentStatusString = json['payment_status_string'];
    deliveryStatus = json['delivery_status'];
    deliveryStatusString = json['delivery_status_string'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['variation'] = variation;
    _data['price'] = price;
    _data['tax'] = tax;
    _data['shipping_cost'] = shippingCost;
    _data['coupon_discount'] = couponDiscount;
    _data['quantity'] = quantity;
    _data['payment_status'] = paymentStatus;
    _data['payment_status_string'] = paymentStatusString;
    _data['delivery_status'] = deliveryStatus;
    _data['delivery_status_string'] = deliveryStatusString;
    return _data;
  }
}
