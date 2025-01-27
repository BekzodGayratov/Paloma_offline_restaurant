import 'package:offline_restaurant/data/datasources/order_local_data_source.dart';
import 'package:offline_restaurant/domain/entities/order_entity.dart';
import 'package:offline_restaurant/domain/entities/order_item_entity.dart';
import 'package:offline_restaurant/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource _localDataSource;

  OrderRepositoryImpl(this._localDataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    try {
      return await _localDataSource.getOrders();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  @override
  Future<void> createOrder({
    required List<OrderItemModel> items,
    required double totalAmount,
  }) async {
    try {
      // Calculate total amount if not provided
      final calculatedTotal = items.fold<double>(
        0,
        (sum, item) => sum + (item.quantity * item.priceAtOrder),
      );

      // Validate total amount matches calculated total
      if (totalAmount != calculatedTotal) {
        throw Exception('Total amount mismatch');
      }

      // Create new order with items
      await _localDataSource.createOrder(
        items: items,
        totalAmount: totalAmount,
      );
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}