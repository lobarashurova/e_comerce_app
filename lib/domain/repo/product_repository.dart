import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';

abstract class ProductRepository{
  Future<List<ProductModel>> getAllProducts({int? limit, int? skip});
  List<BasketLocalModel> getAllBasketData();
  List<Product> getAllFavouriteData();
  Future<void> addProductToBasket(BasketLocalModel basketLocalModel);
  Future<void> addToFavourite(Product product);
  Future<void> removeProductFromFav(int id);
  Future<void> updateProductCount(BasketLocalModel basketModel);
  Future<void> clearAllProductFromBasket();
  bool isInFavStorage(int id);
}