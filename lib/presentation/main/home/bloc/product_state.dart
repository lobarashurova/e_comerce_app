
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:equatable/equatable.dart';
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final List<ProductModel> oldProducts;
  final bool isFirstFetch;

  const ProductLoading({
    this.oldProducts = const [],
    this.isFirstFetch = true
  });

  @override
  List<Object?> get props => [oldProducts, isFirstFetch];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final bool hasReachedMax;

  const ProductLoaded({
    required this.products,
    this.hasReachedMax = false
  });

  ProductLoaded copyWith({
    List<ProductModel>? products,
    bool? hasReachedMax,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [products, hasReachedMax];
}

class ProductError extends ProductState {
  final String message;
  final List<ProductModel> oldProducts;

  const ProductError({
    required this.message,
    this.oldProducts = const []
  });

  @override
  List<Object?> get props => [message, oldProducts];
}