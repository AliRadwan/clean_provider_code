class HttpResponse<T>{
  final T data;
  // final String message;
  final int statusCode;
  final Map<String, dynamic> headers;
  HttpResponse({required this.data,
    // required this.message,
    required this.statusCode, required this.headers});
}