part of 'get_orders_cubit.dart';

enum GetOrdersStatus { initial, loading, failed, success }

class GetOrdersState extends Equatable {
  const GetOrdersState({
    this.status = GetOrdersStatus.initial,
    this.orders = const [],
    this.error,
  });

  final GetOrdersStatus status;
  final List<OrderEntity> orders;
  final String? error;

  GetOrdersState copyWith({
    GetOrdersStatus? status,
    List<OrderEntity>? orders,
    String? error,
  }) {
    return GetOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, orders, error];
}