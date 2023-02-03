import 'package:dart_week_delivery/app/core/ui/theme/theme_config.dart';
import 'package:dart_week_delivery/app/pages/auth/login/login_router.dart';
import 'package:dart_week_delivery/app/pages/home/widgets/home_router.dart';
import 'package:dart_week_delivery/app/pages/order/order_completed_page.dart';
import 'package:dart_week_delivery/app/pages/order/order_router.dart';
import 'package:dart_week_delivery/app/pages/product_detail/product_detail_router.dart';
import 'package:dart_week_delivery/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'core/global/global_context.dart';
import 'core/provider/application_binding.dart';
import 'pages/auth/register/register_router.dart';

class DartWeekDeliveryApp extends StatelessWidget {
  final _naviKey = GlobalKey<NavigatorState>();

  DartWeekDeliveryApp({super.key}) {
    GlobalContext.instance.navigatorKey = _naviKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Dart Week Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        navigatorKey: _naviKey,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
        },
      ),
    );
  }
}
