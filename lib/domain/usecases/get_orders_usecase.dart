import 'package:offline_restaurant/domain/entities/category_entity.dart';
import 'package:offline_restaurant/domain/entities/order_entity.dart';
import 'package:offline_restaurant/domain/repositories/category_repository.dart';
import 'package:offline_restaurant/domain/repositories/order_repository.dart';

class GetOrdersUsecase {
  final OrderRepository _repository;

  GetOrdersUsecase(this._repository);

  Future<List<OrderEntity>> call() {
    return _repository.getOrders();
  }
}
