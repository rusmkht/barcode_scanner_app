import 'package:barcode_scanner/core/api/product_api_data_source.dart';
import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/repositories/product_repo.dart';
import 'package:barcode_scanner/core/utils/http_call_utils.dart';
import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:barcode_scanner/feature/products/data/model/product_model.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductApiDataSource _dataSource;
  ProductRepoImpl() : _dataSource = sl<ProductApiDataSource>();

  @override
  Future<ProductDetailsModel> fetchProductDetails(String id) {
    return safeApiCall<ProductDetailsModel>(
        _dataSource.fetchProductDetails(id), ProductDetailsModel.fromJson);
  }

  @override
  Future<List<ProductModel>> fetchProducts() async {
    return safeApiCallList<List<ProductModel>>(
        _dataSource.fetchProducts(), ProductModel.fromJsonList);
  }

  @override
  Future<ProductDetailsModel> scanBarCode(String barcode) {
    return safeApiCall<ProductDetailsModel>(
        _dataSource.scanBarcode(barcode), ProductDetailsModel.fromJson);
  }
}
