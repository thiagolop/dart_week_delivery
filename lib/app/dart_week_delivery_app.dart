import 'package:dart_week_delivery/app/core/ui/theme/theme_config.dart';
import 'package:dart_week_delivery/app/pages/auth/login/login_router.dart';
import 'package:dart_week_delivery/app/pages/home/widgets/home_router.dart';
import 'package:dart_week_delivery/app/pages/order/order_page.dart';
import 'package:dart_week_delivery/app/pages/product_detail/product_detail_router.dart';
import 'package:dart_week_delivery/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'core/provider/application_binding.dart';
import 'pages/auth/register/register_router.dart';

class DartWeekDeliveryApp extends StatelessWidget {
  const DartWeekDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Dart Week Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => const OrderPage(),
        },
      ),
    );
  }
}
