import 'package:offline_restaurant/features/order_managent/data/datasources/table_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';
import 'package:offline_restaurant/features/order_managent/data/models/table_model.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/table_repository.dart';

class TableRepositoryImpl implements TableRepository {
  final TableLocalDataSource _localDataSource;

  TableRepositoryImpl(this._localDataSource);

  @override
  Future<List<TableEntity>> getTables() async {
    return await _localDataSource.getTables();
  }

  @override
  Future<void> addTable(TableEntity table) async {
    return await _localDataSource.insertTable(TableModel(
      id: table.id,
      name: table.name,
      status: table.status,
    ));
  }
}
