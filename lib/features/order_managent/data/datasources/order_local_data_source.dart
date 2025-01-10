import 'package:sqflite/sqflite.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_item_entity.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderEntity>> getOrders();
  Future<void> createOrder({
    required List<OrderItemModel> items,
    required double totalAmount,
  });
  Future<List<OrderItemModel>> getOrderItems(int orderId);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final Database _db;

  OrderLocalDataSourceImpl(this._db);

  @override
  Future<List<OrderEntity>> getOrders() async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'orders',
      orderBy: 'orderDate DESC', // Most recent first
    );
    
    return List.generate(
      maps.length, 
      (i) => OrderModel.fromJson(maps[i])
    );
  }

  @override
  Future<void> createOrder({
    required List<OrderItemModel> items,
    required double totalAmount,
  }) async {
    await _db.transaction((txn) async {
      // Insert the order first
      final OrderModel order = OrderModel(
        id: null, // SQLite will generate
        orderDate: DateTime.now(),
        totalAmount: totalAmount,
        status: 'completed'
      );

      final orderId = await txn.insert('orders', order.toJson());

      // Insert all order items
      for (var item in items) {
        final orderItem = OrderItemModel(
          id: null, // SQLite will generate
          orderId: orderId,
          productId: item.productId,
          quantity: item.quantity,
          priceAtOrder: item.priceAtOrder,
        );

        await txn.insert('order_items', orderItem.toJson());
      }
    });
  }

  @override
  Future<List<OrderItemModel>> getOrderItems(int orderId) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'order_items',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );

    return List.generate(
      maps.length, 
      (i) => OrderItemModel.fromJson(maps[i])
    );
  }
}