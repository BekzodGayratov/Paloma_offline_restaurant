import 'package:offline_restaurant/features/order_managent/data/datasources/order_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/models/order_model.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl(this._localDataSource);
  final OrderLocalDataSource _localDataSource;
  @override
  Future<List<OrderEntity>> getOrders() {
    return _localDataSource.getOrders();
  }

  @override
  Future<void> addOrder(OrderEntity order) {
    return _localDataSource.insertOrder(OrderModel(
        productId: order.productId,
        quantity: order.quantity,
        tableId: order.tableId));
  }
}
