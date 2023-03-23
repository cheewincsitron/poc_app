import 'api_service.dart';
import '../requester/requester.dart';

class HttpService implements ApiService {
  final Requester requester;

  HttpService({required this.requester});

  @override
  Future<Map<String, dynamic>> fetchData(
      {required String url,
      Map<String, dynamic> queryParams = const {}}) async {
    return await requester.get(url, queryParams: queryParams);
  }

  @override
  Future<Map<String, dynamic>> post(
      {required String url,
      Map<String, dynamic> bodyParams = const {},
      Map<String, dynamic> queryParams = const {}}) async {
    return await requester.post(url,
        bodyParams: bodyParams, queryParams: queryParams);
  }
}
