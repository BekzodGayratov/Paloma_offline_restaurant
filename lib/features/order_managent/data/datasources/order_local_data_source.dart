import 'package:offline_restaurant/features/order_managent/data/models/order_model.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderEntity>> getOrders();
  Future<void> insertOrder(OrderModel order);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  OrderLocalDataSourceImpl(this._db);
  final Database _db;

  @override
  Future<List<OrderEntity>> getOrders() async {
    final List<Map<String, dynamic>> maps = await _db.query('orders');
    return List.generate(maps.length, (i) => OrderModel.fromJson(maps[i]));
  }

  @override
  Future<void> insertOrder(OrderModel order) async {
    await _db.insert('orders', order.toJson());
  }
}
