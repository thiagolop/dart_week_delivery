import 'package:dart_week_delivery/app/core/extensions/formatter_extensions.dart';
import 'package:dart_week_delivery/app/core/ui/styles/colors_app.dart';
import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/models/product_model.dart';
import 'package:flutter/material.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  const DeliveryProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    product.name,
                    style: context.textStyles.textExtraBold.copyWith(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    product.description,
                    style: context.textStyles.textRegular.copyWith(fontSize: 12),
                  ),
                ),
                Text(
                  product.price.currencyPTBR,
                  style: context.textStyles.textMedium.copyWith(fontSize: 12, color: context.colorsApp.secondaryColor),
                ),
              ],
            ),
          ),
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: product.image,
            width: 100,
            height: 100,
            fit: BoxFit.scaleDown,
          )
        ],
      ),
    );
  }
}
