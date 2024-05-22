import 'package:barcode_scanner/feature/products/data/model/product_model.dart';
import 'package:barcode_scanner/feature/products/ui/product_details/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.productModel});

  final ProductModel productModel;

  void onTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          // instead 'apple.json' must be productModel.id
          return const ProductDetailsScreenBuilder(idOrModel: 'apple.json');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: ListTile(
        title: Text(
          productModel.name,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        trailing: Text(
          '${productModel.price} тенге',
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Категория: ${productModel.category}',
            ),
            Text(
              'Вес: ${productModel.weight}',
            ),
            Text(
              'Срок годности: ${productModel.expiry}',
            ),
          ],
        ),
      ),
    );
  }
}
