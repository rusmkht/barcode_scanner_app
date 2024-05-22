import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/utils/exeption/exception.dart';
import 'package:barcode_scanner/core/utils/mixins/request_worker_mixin.dart';
import 'package:barcode_scanner/feature/products/data/model/product_model.dart';
import 'package:barcode_scanner/feature/products/domain/use_case/get_products_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> with CoreRequestWorkedMixin {
  final GetProductsUseCase _getProductsUseCase;

  ProductsCubit()
      : _getProductsUseCase = sl<GetProductsUseCase>(),
        super(ProductsLoadingS()) {
    showErrorExceptionCallback = (error) {
      emit(ProductsErrorS(error: error ?? ''));
    };
  }

  Future<void> fetchProducts() async {
    final request = _getProductsUseCase.execute();
    launchWithError<List<ProductModel>, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(ProductsLoadingS()),
      resultData: (result) => emit(ProductsLoadedS(products: result)),
      errorData: (errorData) {
        print(errorData.toString());
        emit(ProductsErrorS(error: errorData.toString()));
      },
    );
  }
}
