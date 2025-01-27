import 'package:offline_restaurant/data/datasources/category_local_data_source.dart';
import 'package:offline_restaurant/data/models/category_model.dart';
import 'package:offline_restaurant/domain/entities/category_entity.dart';
import 'package:offline_restaurant/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl(this._localDataSource);
  final CategoryLocalDataSource _localDataSource;

  @override
  Future<List<CategoryEntity>> getCategories() {
    return _localDataSource.getCategories();
  }

  @override
  Future<void> addCategory(CategoryEntity category) {
    return _localDataSource
        .insertCategory(CategoryModel(id: category.id, title: category.title));
  }
}
