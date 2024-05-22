import 'package:barcode_scanner/core/common/app_labels.dart';
import 'package:barcode_scanner/feature/products/ui/product_details/cubit/product_details_cubit.dart';
import 'package:barcode_scanner/feature/products/ui/product_details/screen/widgets/product_detail_photo_widget.dart';
import 'package:barcode_scanner/feature/products/ui/product_details/screen/widgets/product_general_info_widget.dart';
import 'package:barcode_scanner/feature/products/ui/product_details/screen/widgets/product_info_header.dart';
import 'package:barcode_scanner/feature/products/ui/product_details/screen/widgets/product_nutrition_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreenBuilder extends StatelessWidget {
  const ProductDetailsScreenBuilder({
    super.key,
    required this.idOrModel,
  });
  final dynamic idOrModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..fetchProductDetails(idOrModel),
      child: const ProductDetailsScreen(),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLabels.productDetails),
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailPhotoWidget(images: state.product.images),
                const ProductInfoHeader(
                  text: AppLabels.generalInfo,
                ),
                ProductGeneralInfoWidget(
                  name: state.product.name,
                  price: state.product.price,
                  description: state.product.description,
                  type: state.product.type,
                ),
                const ProductInfoHeader(
                  text: AppLabels.productValue,
                ),
                ProductNutritionInfoWidget(
                  nutritionalInfo: state.product.nutritionalInfo,
                ),
              ],
            );
          } else if (state is ProductDetailsError) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
