import '../models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;

  OrderProductDto({required this.product, required this.amount});
  double get totalPrice => product.price * amount;
}
