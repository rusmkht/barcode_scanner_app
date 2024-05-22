import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:flutter/material.dart';

class ProductDetailPhotoWidget extends StatelessWidget {
  const ProductDetailPhotoWidget({
    super.key,
    required this.images,
  });

  final List<ImageData> images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        child: PageView.builder(
          itemBuilder: (context, index) => Image.network(
            images[index].url,
          ),
          itemCount: images.length,
        ),
      ),
    );
  }
}
