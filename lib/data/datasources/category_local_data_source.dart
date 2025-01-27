import 'package:offline_restaurant/data/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel category);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl(this._db);
  final Database _db;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final List<Map<String, dynamic>> maps = await _db.query('categories');
    return List.generate(maps.length, (i) => CategoryModel.fromJson(maps[i]));
  }

  @override
  Future<void> insertCategory(CategoryModel category) async {
    await _db.insert('categories', category.toJson());
  }
}
