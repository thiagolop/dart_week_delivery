import 'package:dart_week_delivery/app/dto/orderdto.dart';
import 'package:dart_week_delivery/app/models/payment_type_model.dart';

abstract class OrderRepository {
  Future<List<PaymentTypeModel>> getAllPaymentTypes();
  Future<void> saveOrder(Orderdto order);
}
