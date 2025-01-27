import 'package:offline_restaurant/domain/entities/product_entity.dart';
import 'package:offline_restaurant/domain/repositories/product_repository.dart';

class GetProductsUsecase {
  final ProductRepository _repository;

  GetProductsUsecase(this._repository);

  Future<List<ProductEntity>> call() {
    return _repository.getAllProducts();
  }
}
