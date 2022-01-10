// To parse this JSON data, do
//
//     final paymentTypeResponse = paymentTypeResponseFromJson(jsonString);

import 'dart:convert';

List<PaymentTypeResponse> paymentTypeResponseFromJson(String str) =>
    List<PaymentTypeResponse>.from(json.decode(str).map((x) => PaymentTypeResponse.fromJson(x)));

String paymentTypeResponseToJson(List<PaymentTypeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentTypeResponse {
  PaymentTypeResponse({
    required this.payment_type,
    required this.payment_type_key,
    required this.image,
    required this.name,
    required this.title,
  });

  final String payment_type;
  final String payment_type_key;
  final String image;
  final String name;
  final String title;

  factory PaymentTypeResponse.fromJson(Map<String, dynamic> json) => PaymentTypeResponse(
      payment_type: json["payment_type"],
      payment_type_key: json["payment_type_key"],
      image: json["image"],
      name: json["name"],
      title: json["title"]);

  Map<String, dynamic> toJson() =>
      {"payment_type": payment_type, "payment_type_key": payment_type_key, "image": image, "name": name, "title": title};
}
