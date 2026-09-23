
import 'package:flutter/foundation.dart';

import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/data/repositories/favorites_repository.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FavoritesRepository repository;

  List<ProductModel> favorites = [];

  FavoritesViewModel({FavoritesRepository? repository})
      : repository = repository ?? FavoritesRepository();

  int get count => favorites.length;

  Future<void> init() async {
    await repository.init();
    await loadFavorites();
  }

  Future<void> loadFavorites() async {
    favorites = await repository.getFavorites();
    notifyListeners();
  }

  bool isFavorite(int id) {
    return favorites.any((product) => product.id == id);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (isFavorite(product.id)) {
      await repository.removeFavorite(product.id);
    } else {
      await repository.addFavorite(product);
    }
  
    await loadFavorites();
  }

  Future<void> clearAll() async {
    await repository.clearFavorites();
    await loadFavorites();
  }
}