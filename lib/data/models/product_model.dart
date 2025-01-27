import 'package:offline_restaurant/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({super.amount, super.categoryId, super.id, super.title});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      amount: json['price'],
      categoryId: json['categoryId'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': amount,
      'categoryId': categoryId,
      'title': title
    };
  }
}
