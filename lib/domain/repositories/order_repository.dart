import 'package:offline_restaurant/data/datasources/order_local_data_source.dart';
import 'package:offline_restaurant/domain/entities/order_entity.dart';
import 'package:offline_restaurant/domain/entities/order_item_entity.dart';

abstract class OrderRepository {
  // Create and save a new order
  Future<void> createOrder({
    required List<OrderItemModel> items,
    required double totalAmount,
  });

  // Get all saved orders for display
  Future<List<OrderEntity>> getOrders();
}
