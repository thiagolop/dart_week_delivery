import 'package:dart_week_delivery/app/core/rest_client/custom_dio.dart';
import 'package:dart_week_delivery/app/models/product_model.dart';
import 'package:dio/dio.dart';

import './products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio dio;
  ProductsRepositoryImpl({required this.dio});

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await dio.unauth().get('/products');
      return (result.data).map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
