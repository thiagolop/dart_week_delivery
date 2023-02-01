import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart_week_delivery/app/core/extensions/formatter_extensions.dart';
import 'package:dart_week_delivery/app/core/ui/helpes/size.extensions.dart';
import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_inc_dec_button.dart';
import 'package:dart_week_delivery/app/dto/order_product_dto.dart';
import 'package:dart_week_delivery/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;
  const ProductDetailPage({super.key, required this.product, this.order});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirDelete(int amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja excluir o produto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pop(OrderProductDto(product: widget.product, amount: amount));
              },
              child: const Text('Confirmar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: Column(children: [
        Container(
          width: context.screenWidth,
          height: context.screenHeight * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.product.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.product.name, style: context.textStyles.textExtraBold.copyWith(fontSize: 22)),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Text(widget.product.description, style: context.textStyles.textRegular.copyWith(fontSize: 16)),
            ),
          ),
        ),
        const Divider(),
        Row(
          children: [
            Container(
              width: context.percentWith(0.5),
              height: 68,
              padding: const EdgeInsets.all(8),
              child: BlocBuilder<ProductDetailController, int>(builder: (context, amaunt) {
                return DeliveryIncDecButton(
                  amount: amaunt,
                  onDecrement: () => controller.decrement(),
                  onIncrement: () => controller.increment(),
                );
              }),
            ),
            Container(
              width: context.percentWith(0.5),
              height: 68,
              padding: const EdgeInsets.all(8),
              child: BlocBuilder<ProductDetailController, int>(
                builder: (context, amount) {
                  return ElevatedButton(
                    style: amount == 0 ? ElevatedButton.styleFrom(backgroundColor: Colors.red) : null,
                    onPressed: () {
                      if (amount == 0) {
                        _showConfirDelete(amount);
                      } else {
                        Navigator.of(context).pop(OrderProductDto(product: widget.product, amount: amount));
                      }
                    },
                    child: Visibility(
                      visible: amount > 0,
                      replacement: Text('Excluir Produto', style: context.textStyles.textExtraBold),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Adicionar', style: context.textStyles.textExtraBold.copyWith(fontSize: 13)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AutoSizeText(
                              (widget.product.price * amount).currencyPTBR,
                              maxLines: 1,
                              maxFontSize: 13,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: context.textStyles.textExtraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )
      ]),
    );
  }
}
