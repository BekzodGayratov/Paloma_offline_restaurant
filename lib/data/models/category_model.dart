import 'package:offline_restaurant/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({super.id, required super.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
    };
  }
}
