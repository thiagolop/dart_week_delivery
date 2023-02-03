import 'package:dart_week_delivery/app/repositories/order/order_repository.dart';
import 'package:dart_week_delivery/app/repositories/order/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(create: (context) => OrderRepositoryImpl(dio: context.read())),
          Provider(create: (context) => OrderController(context.read())),
        ],
        child: const OrderPage(),
      );
}
