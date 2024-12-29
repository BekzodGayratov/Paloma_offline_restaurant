import 'package:offline_restaurant/features/order_managent/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();

  Future<void> addCategory(CategoryEntity category);
}
