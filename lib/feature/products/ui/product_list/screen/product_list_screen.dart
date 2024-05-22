import 'package:barcode_scanner/core/common/app_labels.dart';
import 'package:barcode_scanner/feature/products/ui/product_list/cubit/products_cubit.dart';
import 'package:barcode_scanner/feature/products/ui/product_list/screen/widgets/product_widget.dart';
import 'package:barcode_scanner/feature/products/ui/product_list/screen/widgets/scanner_action_button.dart';
import 'package:barcode_scanner/feature/products/ui/scan_barcode/cubit/barcode_scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreenBuilder extends StatelessWidget {
  const ProductListScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit()..fetchProducts(),
        ),
        BlocProvider(
          create: (context) => BarcodeScannerCubit(),
        ),
      ],
      child: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLabels.productList),
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsErrorS) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is ProductsLoadedS) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        productModel: state.products[index],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: state.products.length,
                  ),
                ),
              ],
            );
          } else if (state is ProductsLoadingS) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: const ScannerActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
