import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/utils/exeption/exception.dart';
import 'package:barcode_scanner/core/utils/mixins/request_worker_mixin.dart';
import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:barcode_scanner/feature/products/domain/use_case/scan_barcode_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'barcode_scanner_state.dart';

class BarcodeScannerCubit extends Cubit<BarcodeScannerState>
    with CoreRequestWorkedMixin {
  final ScanBarcodeUseCase _scanBarcodeUseCase;

  BarcodeScannerCubit()
      : _scanBarcodeUseCase = sl<ScanBarcodeUseCase>(),
        super(BarcodeScannerInitial()) {
    showErrorHttpCallback = (error, code) {
      emit(BarcodeScannerErrorS(error: code.toString()));
    };
    showErrorExceptionCallback = (error) {
      emit(BarcodeScannerErrorS(error: error.toString()));
    };
  }

  void fetchScanningBarcode(String barcode) {
    final request = _scanBarcodeUseCase.execute(barcode);

    launchWithError<ProductDetailsModel, HttpRequestException>(
        request: request,
        loading: (isLoading) => emit(BarcodeScannerLoadingS()),
        resultData: (result) => emit(BarcodeScannerLoadedS(product: result)),
        errorData: (error) {
          emit(BarcodeScannerErrorS(error: error.message ?? ''));
        });
  }
}
