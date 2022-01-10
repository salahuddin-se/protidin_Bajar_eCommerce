class PurchaseHistoryModel {
  PurchaseHistoryModel({
    required this.data,
    required this.success,
    required this.status,
  });
  late final List<Data> data;
  late final bool success;
  late final int status;

  PurchaseHistoryModel.fromJson(Map<String, dynamic> json) {
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
    required this.code,
    required this.userId,
    required this.shippingAddress,
    required this.paymentType,
    this.shippingType,
    required this.shippingTypeString,
    required this.paymentStatus,
    required this.paymentStatusString,
    required this.deliveryStatus,
    required this.deliveryStatusString,
    required this.grandTotal,
    required this.couponDiscount,
    required this.shippingCost,
    required this.subtotal,
    required this.tax,
    required this.date,
    required this.cancelRequest,
    required this.links,
  });
  late final int id;
  late final String code;
  late final int userId;
  late final ShippingAddress shippingAddress;
  late final String paymentType;
  late final Null shippingType;
  late final String shippingTypeString;
  late final String paymentStatus;
  late final String paymentStatusString;
  late final String deliveryStatus;
  late final String deliveryStatusString;
  late final String grandTotal;
  late final String couponDiscount;
  late final String shippingCost;
  late final String subtotal;
  late final String tax;
  late final String date;
  late final bool cancelRequest;
  late final Links links;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']);
    paymentType = json['payment_type'];
    shippingType = null;
    shippingTypeString = json['shipping_type_string'];
    paymentStatus = json['payment_status'];
    paymentStatusString = json['payment_status_string'];
    deliveryStatus = json['delivery_status'];
    deliveryStatusString = json['delivery_status_string'];
    grandTotal = json['grand_total'];
    couponDiscount = json['coupon_discount'];
    shippingCost = json['shipping_cost'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    date = json['date'];
    cancelRequest = json['cancel_request'];
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['user_id'] = userId;
    _data['shipping_address'] = shippingAddress.toJson();
    _data['payment_type'] = paymentType;
    _data['shipping_type'] = shippingType;
    _data['shipping_type_string'] = shippingTypeString;
    _data['payment_status'] = paymentStatus;
    _data['payment_status_string'] = paymentStatusString;
    _data['delivery_status'] = deliveryStatus;
    _data['delivery_status_string'] = deliveryStatusString;
    _data['grand_total'] = grandTotal;
    _data['coupon_discount'] = couponDiscount;
    _data['shipping_cost'] = shippingCost;
    _data['subtotal'] = subtotal;
    _data['tax'] = tax;
    _data['date'] = date;
    _data['cancel_request'] = cancelRequest;
    _data['links'] = links.toJson();
    return _data;
  }
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.userId,
    required this.address,
    required this.country,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.setDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.email,
  });
  late final int id;
  late final int userId;
  late final String address;
  late final String country;
  late final String city;
  late final String postalCode;
  late final String phone;
  late final int setDefault;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final String email;

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    setDefault = json['set_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    email = json['email'];
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
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}

class Links {
  Links({
    required this.details,
  });
  late final String details;

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['details'] = details;
    return _data;
  }
}
