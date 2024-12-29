class ProductEntity {
  final int? id;
  final String? title;
  final num? amount;
  final int? categoryId;

  ProductEntity({this.id, this.title,required this.amount,required this.categoryId});
}
