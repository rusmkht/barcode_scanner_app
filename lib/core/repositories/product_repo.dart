import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:barcode_scanner/feature/products/data/model/product_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductDetailsModel> fetchProductDetails(String name);
  Future<ProductDetailsModel> scanBarCode(String barCode);
}
