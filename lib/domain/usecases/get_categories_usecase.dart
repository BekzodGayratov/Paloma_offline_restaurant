import 'package:offline_restaurant/domain/entities/category_entity.dart';
import 'package:offline_restaurant/domain/repositories/category_repository.dart';

class GetCategoriesUsecase {
  final CategoryRepository _repository;

  GetCategoriesUsecase(this._repository);

  Future<List<CategoryEntity>> call() {
    return _repository.getCategories();
  }
}
