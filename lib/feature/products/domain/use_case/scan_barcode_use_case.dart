import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/use_cases/use_cases.dart';
import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:barcode_scanner/feature/products/data/repo/product_repo_impl.dart';

class ScanBarcodeUseCase
    extends CoreFutureUseCase<String, ProductDetailsModel> {
  final ProductRepoImpl _productRepoImpl;

  ScanBarcodeUseCase() : _productRepoImpl = sl<ProductRepoImpl>();

  @override
  Future<ProductDetailsModel> execute(String barcode) {
    return _productRepoImpl.scanBarCode(barcode);
  }
}
