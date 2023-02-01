import 'package:dart_week_delivery/app/core/ui/styles/colors_app.dart';
import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DeliveryIncDecButton extends StatelessWidget {
  final int amount;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  const DeliveryIncDecButton({super.key, required this.amount, required this.onDecrement, required this.onIncrement});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.grey),
              onPressed: () => onDecrement(),
            ),
            const SizedBox(width: 10),
            Text(
              amount.toString(),
              style: context.textStyles.textExtraBold.copyWith(
                fontSize: 16,
                color: context.colorsApp.secondaryColor,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.add,
                color: context.colorsApp.secondaryColor,
              ),
              onPressed: () => onIncrement(),
            ),
          ],
        ));
  }
}
