import 'order_product_dto.dart';

class Orderdto {
  List<OrderProductDto> products;
  String address;
  String document;
  int paymentMethodID;
  Orderdto({
    required this.products,
    required this.address,
    required this.document,
    required this.paymentMethodID,
  });
}
