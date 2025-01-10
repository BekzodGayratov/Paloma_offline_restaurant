import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_item_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/order_repository.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final OrderRepository _orderRepository;

  CreateOrderCubit(this._orderRepository) : super(const CreateOrderState());

  Future<void> createOrder({
    required List<OrderItemModel> items,
    required double totalAmount,
  }) async {
    emit(state.copyWith(status: CreateOrderStatus.loading));
    try {
      await _orderRepository.createOrder(
        items: items,
        totalAmount: totalAmount,
      );
      emit(state.copyWith(
        status: CreateOrderStatus.success,
        orderItems: [], // Clear cart after successful order
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CreateOrderStatus.failed,
        error: e.toString(),
      ));
      rethrow; // Allow UI to handle the error
    }
  }

  void addItem(OrderItemModel item) {
    final newItems = List<OrderItemModel>.from(state.orderItems)..add(item);
    emit(state.copyWith(orderItems: newItems));
  }

  void updateItemQuantity(int index, int newQuantity) {
    if (newQuantity < 1) return;

    final newItems = List<OrderItemModel>.from(state.orderItems);

    // Cast to OrderItemModel to use copyWith
    final item = newItems[index];
    newItems[index] = item.copyWith(quantity: newQuantity);

    emit(state.copyWith(orderItems: newItems));
  }

  void removeItem(int index) {
    final newItems = List<OrderItemModel>.from(state.orderItems)
      ..removeAt(index);
    emit(state.copyWith(orderItems: newItems));
  }
}
