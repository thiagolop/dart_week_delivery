import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:dart_week_delivery/app/models/product_model.dart';
import 'package:dart_week_delivery/app/pages/order/widget/order_field.dart';
import 'package:dart_week_delivery/app/pages/order/widget/order_product_tile.dart';
import 'package:dart_week_delivery/app/pages/order/widget/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import '../../dto/order_product_dto.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Carrinho',
                  style: context.textStyles.textTitle,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/trashRegular.png'),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context, index) {
              return Column(
                children: [
                  OrderProductTile(
                    index: index,
                    orderProductDto: OrderProductDto(
                      product: ProductModel.fromMap({}),
                      amount: 10,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                ],
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total do Pedido', style: context.textStyles.textExtraBold.copyWith(fontSize: 16)),
                    Text(r'R$ 200,00', style: context.textStyles.textExtraBold.copyWith(fontSize: 20)),
                  ],
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              OrderField(
                title: 'Endereço de Entrega',
                controller: TextEditingController(),
                validator: Validatorless.required('m'),
                hinText: 'Digite um Endereço',
              ),
              const SizedBox(height: 10),
              OrderField(
                title: 'CPF',
                controller: TextEditingController(),
                validator: Validatorless.required('m'),
                hinText: 'Digite o CPF',
              ),
              const PaymentTypesField(),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DeliveryButton(
                  width: double.infinity,
                  height: 48,
                  label: 'FINALIZAR',
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
