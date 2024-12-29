import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/table_repository.dart';

class GetTablesUsecase {
  final TableRepository _repository;
  GetTablesUsecase(this._repository);

  Future<List<TableEntity>> call() async {
    return await _repository.getTables();
  }
}
