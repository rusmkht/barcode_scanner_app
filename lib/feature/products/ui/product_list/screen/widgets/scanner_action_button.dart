import 'package:barcode_scanner/feature/products/ui/product_details/screen/product_details_screen.dart';
import 'package:barcode_scanner/feature/products/ui/scan_barcode/cubit/barcode_scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScannerActionButton extends StatelessWidget {
  const ScannerActionButton({
    super.key,
  });

  onTap(BuildContext context) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ));

    if (res is String) {
      context.read<BarcodeScannerCubit>().fetchScanningBarcode(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onTap(context),
      child: BlocConsumer<BarcodeScannerCubit, BarcodeScannerState>(
        listener: (context, state) {
          if (state is BarcodeScannerLoadedS) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProductDetailsScreenBuilder(idOrModel: state.product);
                },
              ),
            );
          } else if (state is BarcodeScannerErrorS) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is BarcodeScannerLoadingS) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Icon(
            Icons.document_scanner_rounded,
          );
        },
      ),
    );
  }
}
