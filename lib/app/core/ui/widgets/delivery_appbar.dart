import 'package:flutter/material.dart';

class DeliveryAppbar extends AppBar {
  DeliveryAppbar({
    super.key,
    double elevation = 1,
  }) : super(
          elevation: 0,
          title: Image.asset('assets/images/logo.png', width: 80),
        );
}
