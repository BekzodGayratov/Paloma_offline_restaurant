import 'package:offline_restaurant/domain/entities/order_item_entity.dart';
import 'package:offline_restaurant/domain/repositories/order_repository.dart';

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
