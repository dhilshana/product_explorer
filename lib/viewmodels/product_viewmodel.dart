import 'package:flutter/foundation.dart';

import 'package:product_explorer/core/error/app_exception.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/data/repositories/product_repository.dart';

enum ProductViewState {
  initial,
  loading,
  loaded,
  error,
  empty,
}

class ProductViewModel extends ChangeNotifier {
  final ProductRepository repository;

  ProductViewState state = ProductViewState.initial;

  List<ProductModel> productsList = [];
  List<String> categories = ['All'];

  String selectedCategory = 'All';

  String? errorMessage;

  // Search state
  List<ProductModel> searchResults = [];
  bool isSearching = false;
  String? searchError;
  String searchQuery = '';

  final Map<String, String> categoryGroups = {
    // Devices
    'smartphones': 'Devices',
    'laptops': 'Devices',
    'tablets': 'Devices',
    'mobile-accessories': 'Devices',

    // Fashion
    'tops': 'Fashion',
    'mens-shirts': 'Fashion',
    'mens-shoes': 'Fashion',
    'mens-watches': 'Fashion',
    'womens-dresses': 'Fashion',
    'womens-shoes': 'Fashion',
    'womens-watches': 'Fashion',
    'sunglasses': 'Fashion',

    // Home
    'home-decoration': 'Home',
    'furniture': 'Home',
    'kitchen-accessories': 'Home',

    // Beauty
    'beauty': 'Beauty',
    'fragrances': 'Beauty',
    'skin-care': 'Beauty',

    // Vehicle
    'motorcycle': 'Vehicle',
    'vehicle': 'Vehicle',

    // Sports
    'sports-accessories': 'Sports',

    // Groceries
    'groceries': 'Groceries',
  };

  ProductViewModel({ProductRepository? repository})
      : repository = repository ?? ProductRepository();

  List<ProductModel> get filteredProducts {
    if (selectedCategory.toLowerCase() == 'all') {
      return productsList;
    }

    return productsList.where((product) {
      final group = categoryGroups[product.category.toLowerCase()];

      return group?.toLowerCase() == selectedCategory.toLowerCase();
    }).toList();
  }

  Future<void> loadInitialData() async {
    await Future.wait([
      fetchCategories(),
      fetchProducts(),
    ]);
  }

  Future<void> fetchProducts() async {
    state = ProductViewState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      productsList = await repository.getProducts();

      if (productsList.isEmpty) {
        state = ProductViewState.empty;
      } else {
        state = ProductViewState.loaded;
      }
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ProductViewState.error;
    } catch (e) {
      errorMessage =
          'Failed to load products. Please check your internet connection and try again.';
      state = ProductViewState.error;
    }

    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      final remoteCategories = await repository.getCategories();

      categories = getGroupedCategories(remoteCategories);

      notifyListeners();
    } catch (e) {
      categories = [
        'All',
        'Beauty',
        'Fragrances',
        'Furniture',
        'Groceries',
      ];

      notifyListeners();
    }
  }

  List<String> getGroupedCategories(List<String> categories) {
    final groupedCategories = <String>['All'];

    for (final category in categories) {
      final group = categoryGroups[category.toLowerCase()] ?? category;

      if (!groupedCategories.contains(group)) {
        groupedCategories.add(group);
      }
    }

    return groupedCategories;
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> search(String query) async {
    searchQuery = query.trim();

    if (searchQuery.isEmpty) {
      searchResults = [];
      isSearching = false;
      searchError = null;
      notifyListeners();
      return;
    }

    isSearching = true;
    searchError = null;
    notifyListeners();

    try {
      searchResults = await repository.searchProducts(searchQuery);
    } on AppException catch (e) {
      searchError = e.message;
      searchResults = [];
    } catch (e) {
      searchError = 'Search failed. Please try again.';
      searchResults = [];
    }

    isSearching = false;
    notifyListeners();
  }

  void clearSearch() {
    searchQuery = '';
    searchResults = [];
    isSearching = false;
    searchError = null;

    notifyListeners();
  }
}