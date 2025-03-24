import 'package:e_comerce_app/common/base/base_storage.dart';
import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Storage {
  Storage(this._box);

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<Storage> create() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(BasketLocalModelAdapter());

    final box = await Hive.openBox('storage');
    await Hive.openBox<Product>('favourites');
    await Hive.openBox<BasketLocalModel>('basket');
    await Hive.openBox<BasketLocalModel>('caches');
    return Storage(box);
  }

  BaseStorage<bool>? get isDark => BaseStorage(_box, "isDark");
  Box<Product> favouriteBox = Hive.box('favourites');
  Box<BasketLocalModel> basketBox = Hive.box('basket');
  Box<BasketLocalModel> cacheBox = Hive.box('caches');

  Future<void> addFavorite(Product product) async {
    debugPrint("Adding to storage =======  \n =====");
    if (!favouriteBox.containsKey(product.id)) {
      await favouriteBox.put(product.id, product);
      debugPrint("Added successfully ==================");
    }
  }

  Future<void> addCacheData(List<BasketLocalModel> product) async {
    debugPrint("Adding to cache =======  \n =====");
    await cacheBox.clear();
    final Map<dynamic, BasketLocalModel> productsMap = {
      for (var data in product) data.id: data
    };
   await cacheBox.putAll(productsMap);
    debugPrint("Added successfully ==================");
  }

  Future<void> removeFavorite(int productId) async {
    await favouriteBox.delete(productId);
  }

  List<Product>? getFavorites() {
    return favouriteBox.values.toList();
  }

  bool isFavorite(int productId) {
    return favouriteBox.containsKey(productId);
  }

  Future<void> addProductBasket(BasketLocalModel basketLocalModel) async {
    if (!basketBox.containsKey(basketLocalModel.id)) {
      await basketBox.put(basketLocalModel.id, basketLocalModel);
      debugPrint("Added successfully to basket ==================");
    } else {
      final existingProduct =
          basketBox.get(basketLocalModel.id) as BasketLocalModel;
      final updatedProduct =
          existingProduct.copyWith(count: (existingProduct.count ?? 0) + 1);
      await basketBox.put(basketLocalModel.id, updatedProduct);
      debugPrint("Product count increased by one ==================");
    }
  }

  Future<void> updateProduct(BasketLocalModel basketLocalModel) async {
    if (basketBox.containsKey(basketLocalModel.id)) {
      await basketBox.put(basketLocalModel.id, basketLocalModel);
    }
  }

  Future<void> removeFromBasket(int productId) async {
    await basketBox.delete(productId);
  }

  Future<void> clearAll() async {
    await basketBox.clear();
  }

  List<BasketLocalModel>? getAllBasketProducts() {
    return basketBox.values.toList();
  }

  bool isInBasket(String productId) {
    return basketBox.containsKey(productId);
  }
}
