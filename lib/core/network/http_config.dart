class HttpConfig {
  final String baseUrl;
  final Duration timeout;
  final Map<String, String> defaultHeaders;


  HttpConfig({
    required this.baseUrl, this.timeout = const Duration(seconds: 30), this.defaultHeaders = const {'Content-Type': 'application/json'},
  });
}