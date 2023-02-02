import 'package:dart_week_delivery/app/core/ui/styles/colors_app.dart';
import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../dto/order_product_dto.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto orderProductDto;
  const OrderProductTile({super.key, required this.index, required this.orderProductDto});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
            'https://picsum.photos/200/300',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(orderProductDto.product.name, style: context.textStyles.textRegular.copyWith(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R\$ ${orderProductDto.product.price}',
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 16,
                        color: context.colorsApp.secondaryColor,
                      ),
                    ),
                    DeliveryIncDecButton(
                      amount: 1,
                      onDecrement: () {},
                      onIncrement: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
