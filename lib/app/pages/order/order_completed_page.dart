import 'package:dart_week_delivery/app/core/ui/helpes/size.extensions.dart';
import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: context.percentHeight(.2)),
            Image.asset('assets/images/logo_rounded.png'),
            const SizedBox(height: 20),
            Text(
              'Pedido realizado com sucesso!',
              textAlign: TextAlign.center,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 40),
            DeliveryButton(
              width: context.percentHeight(.8),
              label: 'FECHAR',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ));
  }
}
