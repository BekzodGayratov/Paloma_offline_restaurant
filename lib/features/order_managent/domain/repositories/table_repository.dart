import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';

abstract class TableRepository {
  Future<List<TableEntity>> getTables();

  Future<void> addTable(TableEntity table);
}
