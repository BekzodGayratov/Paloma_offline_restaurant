class OrderEntity {
  const OrderEntity({
    this.id,
    required this.orderDate,
    required this.totalAmount,
    this.status = 'completed',
  });

  final int? id;  // Nullable for new orders not yet saved
  final DateTime orderDate;
  final double totalAmount;
  final String status;
}

class OrderModel extends OrderEntity {
  OrderModel({
    super.id,
    required super.orderDate,
    required super.totalAmount,
    required super.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      orderDate: DateTime.parse(json['orderDate'] as String),
      totalAmount: json['totalAmount'] as double,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDate': orderDate.toIso8601String(),
      'totalAmount': totalAmount,
      'status': status,
    };
  }
}