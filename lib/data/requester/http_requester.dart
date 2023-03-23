import 'dart:convert';

import 'package:http/http.dart' as http;

import 'requester.dart';

class HttpRequester implements Requester {
  @override
  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParams = const {}}) async {
    try {
      var urlParam = Uri.parse(url).replace(queryParameters: queryParams);
      final http.Response response = await http.get(urlParam);

      if (response.statusCode != 200) {
        throw Exception(response.statusCode.toString());
      }

      return json.decode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> post(String url,
      {Map<String, dynamic>? bodyParams,
      Map<String, dynamic>? queryParams}) async {
    try {
      var urlParam = Uri.parse(url).replace(queryParameters: queryParams);
      final http.Response response =
          await http.post(urlParam, body: bodyParams);

      if (response.statusCode != 200) {
        throw Exception(response.statusCode.toString());
      }

      return json.decode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
