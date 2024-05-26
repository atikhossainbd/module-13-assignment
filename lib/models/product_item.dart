class ProductItem {
  final String? id;
  final String productName;
  final String productCode;
  final String img;
  final String unitPrice;
  final String qty;
  final String totalPrice;

  ProductItem({
    this.id,
    required this.productName,
    required this.productCode,
    required this.img,
    required this.unitPrice,
    required this.qty,
    required this.totalPrice,
  });

  factory ProductItem.formMap(Map<String, dynamic> json) {
    return ProductItem(
      id: json['_id'] ?? '',
      productName: json['ProductName'] ?? '',
      productCode: json['ProductCode'] ?? '',
      img: json['Img'] ?? '',
      unitPrice: json['UnitPrice'] ?? '',
      qty: json['Qty'] ?? '',
      totalPrice: json['TotalPrice'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'ProductName': productName,
    'ProductCode': productCode,
    'Img': img,
    'UnitPrice': unitPrice,
    'Qty': qty,
    'TotalPrice': totalPrice,
  };
}
