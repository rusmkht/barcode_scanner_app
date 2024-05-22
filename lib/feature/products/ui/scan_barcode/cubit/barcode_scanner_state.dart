part of 'barcode_scanner_cubit.dart';

@immutable
abstract class BarcodeScannerState {}

class BarcodeScannerInitial extends BarcodeScannerState {}

class BarcodeScannerLoadingS extends BarcodeScannerState {}

class BarcodeScannerLoadedS extends BarcodeScannerState {
  final ProductDetailsModel product;

  BarcodeScannerLoadedS({required this.product});
}

class BarcodeScannerErrorS extends BarcodeScannerState {
  final String error;

  BarcodeScannerErrorS({required this.error});
}
