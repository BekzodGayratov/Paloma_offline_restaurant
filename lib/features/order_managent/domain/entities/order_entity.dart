class OrderEntity {
  const OrderEntity({this.id, this.productId, this.quantity, this.tableId});
  final int? id;
  final int? tableId;
  final int? productId;
  final int? quantity;
}
