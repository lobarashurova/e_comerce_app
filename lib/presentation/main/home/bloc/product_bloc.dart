import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/di/injection.dart';
import 'package:e_comerce_app/domain/repo/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository = getIt<ProductRepository>();
  static const int _pageSize = 10;

  ProductBloc() : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchMoreProductsEvent>(_onFetchMoreProducts);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (event.refresh) {
        emit(const ProductLoading(isFirstFetch: true));
      } else if (state is! ProductLoaded) {
        emit(const ProductLoading(isFirstFetch: true));
      }

      final List<ProductModel> products = await repository.getAllProducts(
        limit: _pageSize,
        skip: 0,
      );

      final bool hasReachedMax = products.length < _pageSize;
      emit(ProductLoaded(products: products, hasReachedMax: hasReachedMax));
    } catch (e) {
      final currentProducts = state is ProductLoaded
          ? (state as ProductLoaded).products
          : <ProductModel>[];

      emit(ProductError(message: e.toString(), oldProducts: currentProducts));
    }
  }

  Future<void> _onFetchMoreProducts(
    FetchMoreProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      if (currentState.hasReachedMax) return;

      try {
        emit(ProductLoading(
            oldProducts: currentState.products, isFirstFetch: false));

        final newProducts = await repository.getAllProducts(
          limit: _pageSize,
          skip: currentState.products.length,
        );

        final bool hasReachedMax = newProducts.length < _pageSize;

        emit(ProductLoaded(
          products: [...currentState.products, ...newProducts],
          hasReachedMax: hasReachedMax,
        ));
      } catch (e) {
        emit(ProductError(
            message: e.toString(), oldProducts: currentState.products));
      }
    }
  }
}
