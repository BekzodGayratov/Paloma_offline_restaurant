import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';

class TableModel extends TableEntity {
  TableModel({super.id, required super.name, required super.status});

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'status': status,
    };
  }
}
