import 'package:sqflite/sqflite.dart';
import 'package:offline_restaurant/data/models/product_model.dart';
import 'package:offline_restaurant/domain/entities/product_entity.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductEntity>> getProductsByCategory(int categoryId);
  Future<List<ProductEntity>> getAllProducts();
  Future<ProductEntity?> getProductById(int productId);
  Future<void> insertProduct(ProductModel product);
  Future<double> getProductPrice(int productId);
  Future<List<ProductEntity>> searchProducts(String query);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Database _db;

  ProductLocalDataSourceImpl(this._db);

  @override
  Future<List<ProductEntity>> getProductsByCategory(int categoryId) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'products',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );

    return List.generate(maps.length, (i) => ProductModel.fromJson(maps[i]));
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final List<Map<String, dynamic>> maps = await _db.query('products');
    return List.generate(maps.length, (i) => ProductModel.fromJson(maps[i]));
  }

  @override
  Future<ProductEntity?> getProductById(int productId) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return ProductModel.fromJson(maps.first);
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    await _db.insert(
      'products',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<double> getProductPrice(int productId) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'products',
      columns: ['price'],
      where: 'id = ?',
      whereArgs: [productId],
      limit: 1,
    );

    if (maps.isEmpty) throw Exception('Product not found');
    return maps.first['price'] as double;
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'products',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );

    return List.generate(maps.length, (i) => ProductModel.fromJson(maps[i]));
  }
}
