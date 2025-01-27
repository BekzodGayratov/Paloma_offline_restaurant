import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_restaurant/domain/entities/category_entity.dart';
import 'package:offline_restaurant/domain/usecases/get_categories_usecase.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit(this._getCategoriesUsecase)
      : super(const GetCategoriesState());

  final GetCategoriesUsecase _getCategoriesUsecase;
  Future<void> getCategories() async {
    emit(state.copyWith(status: GetCategoriesStatus.loading));
    try {
      final result = await _getCategoriesUsecase();
      emit(state.copyWith(
          categories: result, status: GetCategoriesStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: GetCategoriesStatus.failed, error: e.toString()));
    }
  }
}
