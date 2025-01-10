import 'package:offline_restaurant/features/order_managent/data/datasources/product_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/models/product_model.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/product_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<List<ProductEntity>> getProductsByCategory(int categoryId) async {
    try {
      final products = await localDataSource.getProductsByCategory(categoryId);
      return products;
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final products = await localDataSource.getAllProducts();
      return products;
    } catch (e) {
      throw Exception('Failed to get all products: $e');
    }
  }

  @override
  Future<ProductEntity?> getProductById(int productId) async {
    try {
      final product = await localDataSource.getProductById(productId);
      return product;
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  @override
  Future<void> insertProduct(ProductEntity product) async {
    try {
      await localDataSource.insertProduct(ProductModel(
          amount: product.amount,
          categoryId: product.categoryId,
          id: product.id,
          title: product.title));
    } catch (e) {
      throw Exception('Failed to insert product: $e');
    }
  }

  @override
  Future<double> getProductPrice(int productId) async {
    try {
      final price = await localDataSource.getProductPrice(productId);
      return price;
    } catch (e) {
      throw Exception('Failed to get product price: $e');
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    try {
      final products = await localDataSource.searchProducts(query);
      return products;
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}
