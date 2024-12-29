import 'package:offline_restaurant/features/order_managent/data/models/product_model.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/product_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductEntity>> getProducts();
  Future<void> insertProduct(ProductModel product);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl(this._db);
  final Database _db;

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<Map<String, dynamic>> maps = await _db.query('products');
    return List.generate(maps.length, (i) => ProductModel.fromJson(maps[i]));
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    await _db.insert('products', product.toJson());
  }
}
