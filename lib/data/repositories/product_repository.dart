import 'package:product_explorer/core/constants/api_constants.dart';
import 'package:product_explorer/core/error/app_exception.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/data/services/api_client.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiClient.get(
      ApiConstants.productsEndpoint,
    );

    if (response is Map<String, dynamic> && response['products'] is List) {
      final list = response['products'] as List;
      return list
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw ServerException('Invalid product list response format.');
  }

  Future<List<String>> getCategories() async {
    final response = await _apiClient.get(ApiConstants.categoryListEndpoint);

    if (response is List) {
      return response.map((e) => e.toString()).toList();
    }

    return [];
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final response = await _apiClient.get(
      ApiConstants.searchEndpoint,
      queryParams: {'q': trimmed},
    );

    if (response is Map<String, dynamic> && response['products'] is List) {
      final list = response['products'] as List;
      return list
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw ServerException('Invalid search response format.');
  }
}
