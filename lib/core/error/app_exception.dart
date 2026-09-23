class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Please check your internet connection and try again.']);
}

class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred. Please try again later.', super.statusCode]);
}

class AuthException extends AppException {
  AuthException(super.message);
}
