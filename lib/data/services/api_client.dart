import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:product_explorer/core/constants/api_constants.dart';
import 'package:product_explorer/core/error/app_exception.dart';

class ApiClient {
  final http.Client _client;
  final String baseUrl;

  ApiClient({
    http.Client? client,
    this.baseUrl = ApiConstants.baseUrl,
  }) : _client = client ?? http.Client();

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = _buildUri(endpoint, queryParams);

    try {
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(ApiConstants.timeoutDuration);

      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw NetworkException('Request timed out. Please check your connection.');
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException('An unexpected network error occurred: $e');
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParams) {
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    final fullUrl = '$baseUrl$cleanEndpoint';

    if (queryParams == null || queryParams.isEmpty) {
      return Uri.parse(fullUrl);
    }

    final stringParams = queryParams.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    return Uri.parse(fullUrl).replace(queryParameters: stringParams);
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) return null;
      try {
        return json.decode(response.body);
      } catch (e) {
        throw ServerException('Failed to parse server response.', statusCode);
      }
    } else if (statusCode >= 400 && statusCode < 500) {
      try {
        final errorJson = json.decode(response.body);
        final message = errorJson['message'] ?? 'Client request error ($statusCode).';
        throw AppException(message.toString(), statusCode);
      } catch (e) {
        if (e is AppException) rethrow;
        throw AppException('Client request error ($statusCode).', statusCode);
      }
    } else if (statusCode >= 500) {
      throw ServerException('Server error occurred ($statusCode). Please try again later.', statusCode);
    } else {
      throw AppException('Unexpected HTTP response status: $statusCode', statusCode);
    }
  }
}
