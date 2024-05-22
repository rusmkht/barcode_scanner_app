part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsLoadingS extends ProductsState {}

class ProductsEmptyS extends ProductsState {}

class ProductsErrorS extends ProductsState {
  final String error;

  ProductsErrorS({required this.error});
}

class ProductsLoadedS extends ProductsState {
  final List<ProductModel> products;

  ProductsLoadedS({required this.products});
}
