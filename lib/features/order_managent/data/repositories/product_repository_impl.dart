import 'package:offline_restaurant/features/order_managent/data/datasources/product_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/models/product_model.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/product_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(this._productLocalDataSource);
  final ProductLocalDataSource _productLocalDataSource;

  @override
  Future<List<ProductEntity>> getProducts(int productId) {
    return _productLocalDataSource.getProducts();
  }

  @override
  Future<void> insertProduct(ProductEntity product) {
    return _productLocalDataSource.insertProduct(ProductModel(
        amount: product.amount,
        categoryId: product.categoryId,
        title: product.title));
  }
}
