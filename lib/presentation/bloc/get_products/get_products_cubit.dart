import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/product_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/usecases/get_product_usecase.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit(this._getProductsUsecase) : super(const GetProductsState());

  final GetProductsUsecase _getProductsUsecase;
  Future<void> getProducts() async {
    emit(state.copyWith(status: GetProductsStatus.loading));
    try {
      final result = await _getProductsUsecase();
      emit(state.copyWith(products: result, status: GetProductsStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: GetProductsStatus.failed, error: e.toString()));
    }
  }
}
