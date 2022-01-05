// To parse this JSON data, do
//
//     final sellerResponse = sellerResponseFromJson(jsonString);
// https://app.quicktype.io/

import 'dart:convert';

SellerResponse sellerResponseFromJson(String str) => SellerResponse.fromJson(json.decode(str));

String sellerResponseToJson(SellerResponse data) => json.encode(data.toJson());

class SellerResponse {
  SellerResponse({
    this.sellers,
    this.meta,
    this.success,
    this.status,
  });

  List<Seller>? sellers;
  Meta? meta;
  bool? success;
  int? status;

  factory SellerResponse.fromJson(Map<String, dynamic> json) => SellerResponse(
    sellers: List<Seller>.from(json["data"].map((x) => Seller.fromJson(x))),
    meta: json["meta"] == null ? null :  Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(sellers!.map((x) => x.toJson())),
    "meta": meta == null ? null : meta!.toJson(),
    "success": success,
    "status": status,
  };
}

class Seller {
  int? id;
  int? userId;
  String? type;
  int? webStoreId;
  int? cityId;
  String? area;
  int? verificationStatus;
  String? verificationInfo;
  int? cashOnDeliveryStatus;
  int? adminToPay;
  String? bankName;
  String? bankAccName;
  String? bankAccNo;
  String? bankRoutingNo;
  int? bankPaymentStatus;

  Seller(
      {this.id,
        this.userId,
        this.type,
        this.webStoreId,
        this.cityId,
        this.area,
        this.verificationStatus,
        this.verificationInfo,
        this.cashOnDeliveryStatus,
        this.adminToPay,
        this.bankName,
        this.bankAccName,
        this.bankAccNo,
        this.bankRoutingNo,
        this.bankPaymentStatus});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    webStoreId = json['web_store_id'];
    cityId = json['city_id'];
    area = json['area'];
    verificationStatus = json['verification_status'];
    verificationInfo = json['verification_info'];
    cashOnDeliveryStatus = json['cash_on_delivery_status'];
    adminToPay = json['admin_to_pay'];
    bankName = json['bank_name'];
    bankAccName = json['bank_acc_name'];
    bankAccNo = json['bank_acc_no'];
    bankRoutingNo = json['bank_routing_no'];
    bankPaymentStatus = json['bank_payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['web_store_id'] = this.webStoreId;
    data['city_id'] = this.cityId;
    data['area'] = this.area;
    data['verification_status'] = this.verificationStatus;
    data['verification_info'] = this.verificationInfo;
    data['cash_on_delivery_status'] = this.cashOnDeliveryStatus;
    data['admin_to_pay'] = this.adminToPay;
    data['bank_name'] = this.bankName;
    data['bank_acc_name'] = this.bankAccName;
    data['bank_acc_no'] = this.bankAccNo;
    data['bank_routing_no'] = this.bankRoutingNo;
    data['bank_payment_status'] = this.bankPaymentStatus;
    return data;
  }
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}
