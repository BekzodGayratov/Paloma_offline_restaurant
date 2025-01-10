part of 'get_products_cubit.dart';


enum GetProductsStatus { initial, loading, failed, success }

class GetProductsState extends Equatable {
  const GetProductsState(
      {this.status = GetProductsStatus.initial,
      this.error,
      this.products = const []});
  final GetProductsStatus status;
  final List<ProductEntity> products;
  final String? error;

  GetProductsState copyWith({
    final GetProductsStatus? status,
    final List<ProductEntity>? products,
    final String? error,
  }) {
    return GetProductsState(
        status: status ?? this.status,
        products: products ?? this.products,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, products, error];
}