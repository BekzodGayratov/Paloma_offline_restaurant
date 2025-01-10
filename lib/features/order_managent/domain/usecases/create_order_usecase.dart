import 'package:offline_restaurant/features/order_managent/domain/entities/category_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_item_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/category_repository.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository _repository;

  CreateOrderUsecase(this._repository);

  Future<void> call({
    required List<OrderItemModel> items,
    required double totalAmount,
  }) {
    return _repository.createOrder(items: items, totalAmount: totalAmount);
  }
}
