import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';
import 'package:equatable/equatable.dart';


abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object?> get props => [];
}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {}

class BasketLoaded extends BasketState {
  final List<BasketLocalModel> basketItems;
  final List<Product> favoriteItems;
  final double totalAmount;

  const BasketLoaded({
    required this.basketItems,
    required this.favoriteItems,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [basketItems, favoriteItems, totalAmount];

  BasketLoaded copyWith({
    List<BasketLocalModel>? basketItems,
    List<Product>? favoriteItems,
    double? totalAmount,
  }) {
    return BasketLoaded(
      basketItems: basketItems ?? this.basketItems,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class BasketError extends BasketState {
  final String message;

  const BasketError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductFavoriteStatus extends BasketLoaded {
  final bool isInFavorites;

  ProductFavoriteStatus({
    required this.isInFavorites,
    required List<BasketLocalModel> basketItems,
    required List<Product> favoriteItems,
    required double totalAmount,
  }) : super(
    basketItems: basketItems,
    favoriteItems: favoriteItems,
    totalAmount: totalAmount,
  );
}