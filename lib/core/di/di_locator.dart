import 'package:barcode_scanner/core/api/product_api_data_source.dart';
import 'package:barcode_scanner/core/constants/network_constants.dart';
import 'package:barcode_scanner/core/network/core_network.dart';
import 'package:barcode_scanner/feature/products/data/repo/product_repo_impl.dart';
import 'package:barcode_scanner/feature/products/domain/use_case/get_product_details_use_case.dart';
import 'package:barcode_scanner/feature/products/domain/use_case/get_products_use_case.dart';
import 'package:barcode_scanner/feature/products/domain/use_case/scan_barcode_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initLocator() {
  _registerHttpClients();
  _registerApiService();
  _registerRepoModule();
  _registerUseCaseModule();
}

void _registerRepoModule() {
  sl.registerFactory(() => ProductRepoImpl());
}

void _registerHttpClients() {
  sl.registerSingleton<Dio>(createHttpClient(NetworkConstants.baseUrl));
}

void _registerApiService() {
  sl.registerSingleton(
    ProductApiDataSource(
      sl.get<Dio>(),
    ),
  );
}

void _registerUseCaseModule() {
  sl.registerFactory(GetProductsUseCase.new);
  sl.registerFactory(GetProductDetailsUseCase.new);
  sl.registerFactory(ScanBarcodeUseCase.new);
}
