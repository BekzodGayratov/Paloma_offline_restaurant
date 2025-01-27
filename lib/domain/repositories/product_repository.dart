import 'package:offline_restaurant/domain/entities/product_entity.dart';

abstract class ProductRepository {
  // Get all products in a specific category
  Future<List<ProductEntity>> getProductsByCategory(int categoryId);
  
  // Get all products (might be useful for search or general listing)
  Future<List<ProductEntity>> getAllProducts();
  
  // Get a single product by ID (useful when adding to cart or viewing details)
  Future<ProductEntity?> getProductById(int productId);
  
  // Insert a product (might be needed for initial data population)
  Future<void> insertProduct(ProductEntity product);
  
  // Get product price (useful for order calculations)
  Future<double> getProductPrice(int productId);
  
  // Optional: Search products by name
  Future<List<ProductEntity>> searchProducts(String query);
}