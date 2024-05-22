import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/use_cases/use_cases.dart';
import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:barcode_scanner/feature/products/data/repo/product_repo_impl.dart';

class GetProductDetailsUseCase
    extends CoreFutureUseCase<String, ProductDetailsModel> {
  final ProductRepoImpl _productRepoImpl;

  GetProductDetailsUseCase() : _productRepoImpl = sl<ProductRepoImpl>();

  @override
  Future<ProductDetailsModel> execute(String id) {
    return _productRepoImpl.fetchProductDetails(id);
  }
}
