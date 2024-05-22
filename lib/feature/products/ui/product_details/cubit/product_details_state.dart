part of 'product_details_cubit.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsModel product;
  ProductDetailsLoaded({required this.product});
}

class ProductDetailsError extends ProductDetailsState {
  final String error;
  ProductDetailsError({required this.error});
}
