abstract class ApiService {
  Future<Map<String, dynamic>> fetchData(
      {required String url, Map<String, dynamic> queryParams});
  Future<Map<String, dynamic>> post(
      {required String url,
      Map<String, dynamic> bodyParams,
      Map<String, dynamic> queryParams});
}
