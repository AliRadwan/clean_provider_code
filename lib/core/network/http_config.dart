// class HttpConfig {
//   final String baseUrl;
//   final Duration timeout;
//   final Map<String, String> defaultHeaders;
//
//   HttpConfig({
//     required this.baseUrl,
//     this.timeout = const Duration(seconds: 30),
//     this.defaultHeaders = const {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//   });
// }


class HttpHeader {

  String? _authToken;

  HttpHeader({
    String? authorization,
  });


  Map<String, String> getHeaders({bool requireAuth = false}) {
final Map<String,String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'RefId': '1',
  'X-IBM-Client-Id': "clientId",
  'X-IBM-Client-Secret': "clientSecret",
};

if (requireAuth && _authToken != null) {
  headers['Authorization'] = _authToken!;
}
return headers;
  }

  void setAuthToken(String? token) {
    _authToken = token;
  }



}