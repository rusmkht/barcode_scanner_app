import 'package:barcode_scanner/core/di/di_locator.dart';
import 'package:barcode_scanner/core/utils/mixins/request_worker_mixin.dart';
import 'package:barcode_scanner/feature/products/data/model/product_details.dart';
import 'package:barcode_scanner/feature/products/domain/use_case/get_product_details_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState>
    with CoreRequestWorkedMixin {
  final GetProductDetailsUseCase _getProductDetailsUseCase;

  ProductDetailsCubit()
      : _getProductDetailsUseCase = sl<GetProductDetailsUseCase>(),
        super(ProductDetailsLoading()) {
    showErrorExceptionCallback = (error) {
      emit(ProductDetailsError(error: error ?? ''));
    };
  }

  void fetchProductDetails(dynamic idOrModel) {
    if (idOrModel is ProductDetailsModel) {
      emit(
        ProductDetailsLoaded(product: idOrModel),
      );
      return;
    }

    final request = _getProductDetailsUseCase.execute(idOrModel as String);

    launch(
      request: request,
      loading: (isLoading) => emit(
        ProductDetailsLoading(),
      ),
      resultData: (result) => emit(
        ProductDetailsLoaded(product: result),
      ),
      errorData: (result) => emit(
        ProductDetailsError(error: result),
      ),
    );
  }
}
