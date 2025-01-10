// Data Layer - Model
class OrderItemModel {
  final int? id; // Nullable for new items not yet saved
  final int orderId;
  final int productId;
  final int quantity;
  final double priceAtOrder;
  

  double get totalPrice => quantity * priceAtOrder;

  OrderItemModel({
    this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.priceAtOrder,
  });

  // Convert from JSON (database)
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int,
      orderId: json['orderId'] as int,
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
      priceAtOrder: json['priceAtOrder'] as double,
    );
  }

  // Convert to JSON (database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
      'priceAtOrder': priceAtOrder,
    };
  }

  // Create copy with new values
  OrderItemModel copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    double? priceAtOrder,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      priceAtOrder: priceAtOrder ?? this.priceAtOrder,
    );
  }
}
