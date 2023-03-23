import 'package:dio/dio.dart';

import 'requester.dart';

class DioRequester implements Requester {
  final requester = Dio();

  @override
  Future get(String url, {Map<String, dynamic>? queryParams = const {}}) async {
    try {
      final response = await requester.get(url, queryParameters: queryParams);

      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future post(String url,
      {Map<String, dynamic>? bodyParams,
      Map<String, dynamic>? queryParams}) async {
    try {
      final response = await requester.post(url,
          data: bodyParams, queryParameters: queryParams);

      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
