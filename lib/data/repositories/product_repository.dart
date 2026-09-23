import 'package:product_explorer/core/constants/api_constants.dart';
import 'package:product_explorer/core/error/app_exception.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/data/services/api_client.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<List<ProductModel>> getProducts({int limit = 30, int skip = 0}) async {
    final response = await _apiClient.get(
      ApiConstants.productsEndpoint,
      queryParams: {'limit': limit, 'skip': skip},
    );

    if (response is Map<String, dynamic> && response['products'] is List) {
      final list = response['products'] as List;
      return list
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw ServerException('Invalid product list response format.');
  }
}
