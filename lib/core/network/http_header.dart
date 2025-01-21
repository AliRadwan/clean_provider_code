class HttpHeader {
  HttpHeader._();
  static final HttpHeader instance = HttpHeader._();
  Map<String, String> getHeaders({String? token}) {
    final Map<String,String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = token;
    }
    return headers;
  }
}