import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/usecases/get_orders_usecase.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit(this._getOrdersUsecase) : super(const GetOrdersState());



  final GetOrdersUsecase _getOrdersUsecase;
  Future<void> getOrders() async {
    emit(state.copyWith(status: GetOrdersStatus.loading));
    try {
      final result = await _getOrdersUsecase();
      emit(state.copyWith(
          orders: result, status: GetOrdersStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: GetOrdersStatus.failed, error: e.toString()));
    }
  }
}
