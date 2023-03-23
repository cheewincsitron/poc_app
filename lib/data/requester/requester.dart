abstract class Requester {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParams});
  Future<dynamic> post(String url,
      {Map<String, dynamic>? bodyParams, Map<String, dynamic>? queryParams});
}
