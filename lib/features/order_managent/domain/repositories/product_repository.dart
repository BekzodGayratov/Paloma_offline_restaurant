import 'package:offline_restaurant/features/order_managent/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts(int productId);
   Future<void> insertProduct(ProductEntity product);
}
