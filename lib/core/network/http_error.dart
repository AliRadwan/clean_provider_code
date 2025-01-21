enum NetworkErrorType {
  noInternet,
  timeout,
  serverError,
  unauthorized,
  badRequest,
  notFound,
  unknown,
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final NetworkErrorType errorType;  // Made non-nullable

  NetworkException({
    required this.message,
    this.statusCode,
    this.errorType = NetworkErrorType.unknown,  // Default value
  });

  factory NetworkException.noInternet() => NetworkException(
    message: 'No internet connection',
    errorType: NetworkErrorType.noInternet,
  );

  factory NetworkException.badRequest({int? statusCode}) => NetworkException(
    message: 'Bad request',
    errorType: NetworkErrorType.badRequest,
    statusCode: statusCode ?? 400,
  );

  factory NetworkException.notFound({int? statusCode}) => NetworkException(
    message: 'Not Found',
    errorType: NetworkErrorType.notFound,
    statusCode: statusCode ?? 404,
  );

  factory NetworkException.timeout() => NetworkException(
    message: 'Request timeout',
    errorType: NetworkErrorType.timeout,
    statusCode: 408,
  );

  factory NetworkException.unauthorized() => NetworkException(
    message: 'Unauthorized',
    errorType: NetworkErrorType.unauthorized,
    statusCode: 401,
  );

  factory NetworkException.serverError({int? statusCode}) => NetworkException(
    message: 'Server error',
    errorType: NetworkErrorType.serverError,
    statusCode: statusCode ?? 500,
  );

  @override
  String toString() {
    final errorTypeStr = ' [$errorType]';
    if (statusCode != null) {
      return 'NetworkException$errorTypeStr: $message (Status Code: $statusCode)';
    }
    return 'NetworkException$errorTypeStr: $message';
  }
}
