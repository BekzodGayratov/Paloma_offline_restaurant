import 'package:offline_restaurant/features/order_managent/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrders();
  Future<void> addOrder(OrderEntity order);
  }