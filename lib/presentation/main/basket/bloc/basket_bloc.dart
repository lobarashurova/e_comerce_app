import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/di/injection.dart';
import 'package:e_comerce_app/domain/repo/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basket_event.dart';
import 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final ProductRepository _productRepository=getIt< ProductRepository>();

  BasketBloc()
      :super(BasketInitial()) {
    on<LoadBasketEvent>(_onLoadBasket);
    on<AddProductToBasketEvent>(_onAddProductToBasket);
    on<AddToFavouriteEvent>(_onAddToFavourite);
    on<RemoveProductFromFavEvent>(_onRemoveProductFromFav);
    on<UpdateProductCountEvent>(_onUpdateProductCount);
    on<ClearBasketEvent>(_onClearBasket);
    on<CheckProductInFavoritesEvent>(_onCheckProductInFavorites);
  }


  void _onCheckProductInFavorites(
      CheckProductInFavoritesEvent event,
      Emitter<BasketState> emit
      ) {
    if (state is BasketLoaded) {
      final currentState = state as BasketLoaded;
      final isInFavorites = _productRepository.isInFavStorage(event.productId);

      emit(ProductFavoriteStatus(
        isInFavorites: isInFavorites,
        basketItems: currentState.basketItems,
        favoriteItems: currentState.favoriteItems,
        totalAmount: currentState.totalAmount,
      ));
    }
  }
  Future<void> _onLoadBasket(LoadBasketEvent event, Emitter<BasketState> emit) async {
    emit(BasketLoading());
    try {
      final basketItems =  _productRepository.getAllBasketData();
      final favouriteItems = _productRepository.getAllFavouriteData();
      final totalAmount = _calculateTotalAmount(basketItems);

      emit(BasketLoaded(
        basketItems: basketItems,
        favoriteItems: favouriteItems,
        totalAmount: totalAmount,
      ));
    } catch (e) {
      emit(BasketError(e.toString()));
    }
  }

  Future<void> _onAddProductToBasket(AddProductToBasketEvent event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        await _productRepository.addProductToBasket(event.basketLocalModel);
        final currentState = state as BasketLoaded;
        final updatedBasketItems =  _productRepository.getAllBasketData();
        final totalAmount = _calculateTotalAmount(updatedBasketItems);

        emit(currentState.copyWith(
          basketItems: updatedBasketItems,
          totalAmount: totalAmount,
        ));
      } catch (e) {
        emit(BasketError(e.toString()));
      }
    }
  }

  Future<void> _onAddToFavourite(AddToFavouriteEvent event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        await _productRepository.addToFavourite(event.product);

        final currentState = state as BasketLoaded;
        final updatedFavorites = _productRepository.getAllFavouriteData();

        emit(currentState.copyWith(
          favoriteItems: updatedFavorites,
        ));
      } catch (e) {
        emit(BasketError(e.toString()));
      }
    }
  }

  Future<void> _onRemoveProductFromFav(RemoveProductFromFavEvent event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        await _productRepository.removeProductFromFav(event.id);

        final currentState = state as BasketLoaded;
        final updatedFavorites = _productRepository.getAllFavouriteData();

        emit(currentState.copyWith(
          favoriteItems: updatedFavorites,
        ));
      } catch (e) {
        emit(BasketError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateProductCount(UpdateProductCountEvent event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        await _productRepository.updateProductCount(event.basketModel);

        final currentState = state as BasketLoaded;
        final updatedBasketItems =  _productRepository.getAllBasketData();
        final totalAmount = _calculateTotalAmount(updatedBasketItems);

        emit(currentState.copyWith(
          basketItems: updatedBasketItems,
          totalAmount: totalAmount,
        ));
      } catch (e) {
        emit(BasketError(e.toString()));
      }
    }
  }

  Future<void> _onClearBasket(ClearBasketEvent event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        await _productRepository.clearAllProductFromBasket();

        final currentState = state as BasketLoaded;
        emit(currentState.copyWith(
          basketItems: [],
          totalAmount: 0,
        ));
      } catch (e) {
        emit(BasketError(e.toString()));
      }
    }
  }

  double _calculateTotalAmount(List<BasketLocalModel> basketItems) {
    return basketItems.fold(0, (sum, item) => sum + (item.price ?? 0) * (item.count ?? 0));
  }
}