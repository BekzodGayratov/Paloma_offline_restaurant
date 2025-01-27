import 'package:offline_restaurant/data/models/table_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class TableLocalDataSource {
  Future<List<TableModel>> getTables();
  Future<void> insertTable(TableModel table);
}

class TableLocalDataSourceImpl implements TableLocalDataSource {
  TableLocalDataSourceImpl(this._db);
  final Database _db;

  @override
  Future<List<TableModel>> getTables() async {
    final List<Map<String, dynamic>> maps = await _db.query('tables');
    return List.generate(maps.length, (i) => TableModel.fromJson(maps[i]));
  }

  @override
  Future<void> insertTable(TableModel table) async {
    await _db.insert('tables', table.toJson());
  }
}
