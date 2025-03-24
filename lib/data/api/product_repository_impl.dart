import 'dart:io';

import 'package:e_comerce_app/data/api/product_api.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';
import 'package:e_comerce_app/data/storage/storage.dart';
import 'package:e_comerce_app/domain/repo/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ProductApi _productApi;
  final Storage _storage;

  ProductRepositoryImpl(this._productApi, this._storage);

  @override
  Future<List<ProductModel>> getAllProducts({int? limit, int? skip}) async {
    try {
      final hasInternet = await _checkInternetConnection();

      if (hasInternet) {
        final response = await _productApi.fetchProductsData(limit: limit, skip: skip);
        final products = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        await _cacheProducts(products);
        return products;
      } else {
        return _getCachedProducts();
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
      return _getCachedProducts();
    }
  }

  Future<void> _cacheProducts(List<ProductModel> products) async {
    final basketModels = products.map((product) =>
        BasketLocalModel(
          id: product.id ?? 0,
          name: product.title,
          image: product.thumbnail,
          price: product.price,
          count: 0
        )
    ).toList();

    await _storage.addCacheData(basketModels);
  }
  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  List<ProductModel> _getCachedProducts() {
    try {
      final List<BasketLocalModel> cachedItems = _storage.cacheBox.values.toList();
      return cachedItems.map((item) => ProductModel(
        id: item.id,
        title: item.name,
        thumbnail: item.image,
        price: item.price
      )).toList();
    } catch (e) {
      debugPrint("Error retrieving cached products: $e");
      return [];
    }
  }

  @override
  Future<void> addProductToBasket(BasketLocalModel basketLocalModel) {
   return _storage.addProductBasket(basketLocalModel);
  }

  @override
  Future<void> addToFavourite(Product product) {
    return _storage.addFavorite(product);
  }

  @override
  Future<void> clearAllProductFromBasket() {
    return _storage.clearAll();
  }

  @override
  List<BasketLocalModel> getAllBasketData() {
    return _storage.getAllBasketProducts() ?? [];
  }

  @override
  List<Product> getAllFavouriteData() {
    return _storage.getFavorites() ?? [];
  }

  @override
  Future<void> removeProductFromFav(int id) {
    return _storage.removeFromBasket(id);
  }

  @override
  Future<void> updateProductCount(BasketLocalModel basketModel) {
    return _storage.updateProduct(basketModel);
  }

  @override
  bool isInFavStorage(int id) {
   return _storage.isFavorite(id);
  }
}
