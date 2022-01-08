class CartSummaryModel {
  CartSummaryModel({
    required this.subTotal,
    required this.tax,
    required this.shippingCost,
    required this.discount,
    required this.grandTotal,
    required this.grandTotalValue,
    required this.couponCode,
    required this.couponApplied,
  });
  late final String subTotal;
  late final String tax;
  late final String shippingCost;
  late final String discount;
  late final String grandTotal;
  late final dynamic grandTotalValue;
  late final String couponCode;
  late final bool couponApplied;

  CartSummaryModel.fromJson(Map<String, dynamic> json){
    subTotal = json['sub_total'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    discount = json['discount'];
    grandTotal = json['grand_total'];
    grandTotalValue = json['grand_total_value'];
    couponCode = json['coupon_code'];
    couponApplied = json['coupon_applied'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sub_total'] = subTotal;
    _data['tax'] = tax;
    _data['shipping_cost'] = shippingCost;
    _data['discount'] = discount;
    _data['grand_total'] = grandTotal;
    _data['grand_total_value'] = grandTotalValue;
    _data['coupon_code'] = couponCode;
    _data['coupon_applied'] = couponApplied;
    return _data;
  }
}