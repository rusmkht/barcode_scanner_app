import 'package:flutter/material.dart';

class ProductInfoHeader extends StatelessWidget {
  const ProductInfoHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(text),
    );
  }
}
