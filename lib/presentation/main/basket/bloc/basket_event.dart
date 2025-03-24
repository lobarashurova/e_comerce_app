import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';
import 'package:equatable/equatable.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object?> get props => [];
}

class LoadBasketEvent extends BasketEvent {}

class AddProductToBasketEvent extends BasketEvent {
  final BasketLocalModel basketLocalModel;

  const AddProductToBasketEvent(this.basketLocalModel);

  @override
  List<Object?> get props => [basketLocalModel];
}

class AddToFavouriteEvent extends BasketEvent {
  final Product product;

  const AddToFavouriteEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveProductFromFavEvent extends BasketEvent {
  final int id;

  const RemoveProductFromFavEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateProductCountEvent extends BasketEvent {
  final BasketLocalModel basketModel;

  const UpdateProductCountEvent(this.basketModel);

  @override
  List<Object?> get props => [basketModel];
}

class ClearBasketEvent extends BasketEvent {}


class CheckProductInFavoritesEvent extends BasketEvent {
  final int productId;

  const CheckProductInFavoritesEvent(this.productId);
}