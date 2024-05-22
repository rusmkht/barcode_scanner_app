import 'package:flutter/material.dart';

class ProductGeneralInfoWidget extends StatelessWidget {
  const ProductGeneralInfoWidget({
    super.key,
    required this.name,
    required this.price,
    required this.type,
    required this.description,
  });

  final String name;
  final double price;
  final String type;
  final String description;

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
                  '$name($type)',
                ),
                Text(
                  price.toString(),
                )
              ],
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
