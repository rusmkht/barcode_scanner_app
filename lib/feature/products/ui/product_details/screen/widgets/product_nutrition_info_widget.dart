import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:flutter/material.dart';

class ProductNutritionInfoWidget extends StatelessWidget {
  const ProductNutritionInfoWidget({
    super.key,
    required this.nutritionalInfo,
  });

  final NutritionalInfo nutritionalInfo;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nutritionalInfo.calories.toString(),
                ),
                Text(
                  nutritionalInfo.fat.toString(),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nutritionalInfo.carbohydrates.toString(),
                ),
                Text(
                  nutritionalInfo.protein.toString(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
