import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/use_cases/use_cases.dart';
import 'package:barcode_scanner/feature/products/data/model/product_model.dart';
import 'package:barcode_scanner/feature/products/data/repo/product_repo_impl.dart';

class GetProductsUseCase
    extends CoreFutureNoneParamUseCase<List<ProductModel>> {
  final ProductRepoImpl _productRepoImpl;

  GetProductsUseCase() : _productRepoImpl = sl<ProductRepoImpl>();

  @override
  Future<List<ProductModel>> execute() {
    return _productRepoImpl.fetchProducts();
  }
}
