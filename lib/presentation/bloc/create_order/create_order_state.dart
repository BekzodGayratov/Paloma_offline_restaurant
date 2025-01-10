part of 'create_order_cubit.dart';

enum CreateOrderStatus { initial, loading, failed, success }

class CreateOrderState extends Equatable {
  const CreateOrderState({
    this.status = CreateOrderStatus.initial,
    this.orderItems = const [],
    this.totalAmount = 0.0,
    this.error,
  });

  final CreateOrderStatus status;
  final List<OrderItemModel> orderItems;
  final double totalAmount;
  final String? error;

  CreateOrderState copyWith({
    CreateOrderStatus? status,
    List<OrderItemModel>? orderItems,
    double? totalAmount,
    String? error,
  }) {
    return CreateOrderState(
      status: status ?? this.status,
      orderItems: orderItems ?? this.orderItems,
      totalAmount: totalAmount ?? this.totalAmount,
      error: error ?? this.error,
    );
  }

  // Helper method to calculate total amount
  double calculateTotalAmount() {
    return orderItems.fold(
      0.0,
      (sum, item) => sum + (item.quantity * item.priceAtOrder),
    );
  }

  @override
  List<Object?> get props => [status, orderItems, totalAmount, error];
}