class LogOutCartSummaryModel {
  LogOutCartSummaryModel({
    required this.subTotal,
    required this.tax,
    required this.shipCost,
    required this.discount,
    required this.grand_Total,
  });
  late final String subTotal;
  late final String tax;
  late final String shipCost;
  late final String discount;
  late final String grand_Total;

  LogOutCartSummaryModel.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    tax = json['tax'];
    shipCost = json['shipping_cost'];
    discount = json['discount'];
    grand_Total = json['grand_total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sub_total'] = subTotal;
    _data['tax'] = tax;
    _data['shipping_cost'] = shipCost;
    _data['discount'] = discount;
    _data['grand_total'] = grand_Total;

    return _data;
  }
}
