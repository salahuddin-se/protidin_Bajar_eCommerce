class OrderItemModel {
  int? productId;
  String? variant;
  int? userId;
  int? quantity;
  final String? productName;
  final String? productThumbnailImage;
  final int? price;
  final int? discount;
  final String? discountType;

  OrderItemModel({
    required this.discount,
    required this.discountType,
    this.productId,
    this.variant,
    this.userId,
    this.quantity,
    this.productName,
    this.productThumbnailImage,
    this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderItemModel(
        productId: jsonData['id'],
        variant: jsonData['variant'],
        userId: jsonData['user_id'],
        quantity: jsonData['quantity'],
        productName: jsonData['product_name'],
        price: jsonData['price'],
        productThumbnailImage: jsonData['product_thumbnail'],
        discount: jsonData['discount'],
        discountType: jsonData['discount_type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'variant': variant,
      'user_id': userId,
      'quantity': quantity,
      'product_name': productName,
      "price": price,
      "product_thumbnail": productThumbnailImage,
      'discount': discount,
      'discount_type': discountType,
    };
  }
}

/*
class OrderItemModel {
  int? productId;
  String? variant;
  int? userId;
  int? quantity;
  final String? productName;
  final String? productThumbnailImage;
  final int? price;

  OrderItemModel({this.productId, this.variant, this.userId, this.quantity, this.productName, this.productThumbnailImage, this.price});

  factory OrderItemModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderItemModel(
      productId: jsonData['id'],
      variant: jsonData['variant'],
      userId: jsonData['user_id'],
      quantity: jsonData['quantity'],
      productName: jsonData['product_name'],
      price: jsonData['price'],
      productThumbnailImage: jsonData['product_thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'variant': variant,
      'user_id': userId,
      'quantity': quantity,
      'product_name': productName,
      "price": price,
      "product_thumbnail": productThumbnailImage
    };
  }
}

*/
