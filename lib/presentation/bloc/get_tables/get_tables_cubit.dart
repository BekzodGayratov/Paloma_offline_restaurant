import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/usecases/get_tables_usecase.dart';

part 'get_tables_state.dart';

class GetTablesCubit extends Cubit<GetTablesState> {
  final GetTablesUsecase _getTablesUsecase;
  GetTablesCubit(this._getTablesUsecase) : super(const GetTablesState());

  Future<void> getTables() async {
    emit(state.copyWith(status: GetTablesStatus.loading));
    try {
      final result = await _getTablesUsecase();
      emit(state.copyWith(tables: result, status: GetTablesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: GetTablesStatus.failed, error: e.toString()));
    }
  }
}
