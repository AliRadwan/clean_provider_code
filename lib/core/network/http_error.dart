class HttpError implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  HttpError({required this.message, this.statusCode,this.data});

  @override
  String toString() => 'HttpError: $message (Status Code: $statusCode)';
}