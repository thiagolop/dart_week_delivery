
import 'package:dart_week_delivery/app/pages/home/widgets/home_page.dart';
import 'package:dart_week_delivery/app/repositories/products/products_repository.dart';
import 'package:dart_week_delivery/app/repositories/products/products_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_controller.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(dio: context.read()),
          ),
          Provider(
            create: (context) => HomeController(context.read()),
          )
        ],
        child: const HomePage(),
      );
}
