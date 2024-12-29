import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/table_repository.dart';

class AddTableUsecase {
  final TableRepository _repository;
  AddTableUsecase(this._repository);

  Future<void> call(TableEntity table) async {
    return await _repository.addTable(table);
  }
}
