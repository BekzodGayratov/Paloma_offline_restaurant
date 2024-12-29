import 'package:offline_restaurant/features/order_managent/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({super.id, super.productId, super.quantity, super.tableId});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json["id"],
        productId: json["productId"],
        quantity: json['quantity'],
        tableId: json['tableId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'tableId': tableId,
    };
  }
}
