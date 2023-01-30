import 'package:dart_week_delivery/app/core/ui/theme/theme_config.dart';
import 'package:dart_week_delivery/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class DartWeekDeliveryApp extends StatelessWidget {
  const DartWeekDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart Week Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
