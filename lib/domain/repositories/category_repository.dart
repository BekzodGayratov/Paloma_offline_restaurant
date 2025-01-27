import 'package:offline_restaurant/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();

  Future<void> addCategory(CategoryEntity category);
}
