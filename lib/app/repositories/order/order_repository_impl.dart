import 'package:dart_week_delivery/app/core/rest_client/custom_dio.dart';
import 'package:dart_week_delivery/app/dto/orderdto.dart';
import 'package:dart_week_delivery/app/models/payment_type_model.dart';
import 'package:dio/dio.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({required this.dio});

  @override
  Future<List<PaymentTypeModel>> getAllPaymentTypes() async {
    try {
      final response = await dio.auth().get('/payment-types');
      return response.data.map<PaymentTypeModel>((e) => PaymentTypeModel.fromMap(e)).toList();
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> saveOrder(Orderdto order) async {
    try {
      await dio.auth().post('/orders', data: {
        'products': order.products.map((e) => {'id': e.product.id, 'amount': e.amount, 'total_price': e.totalPrice}).toList(),
        'user_id': '#userAuthRef',
        'address': order.address,
        'CPF': order.document,
        'payment_method_id': order.paymentMethodID,
      });
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
