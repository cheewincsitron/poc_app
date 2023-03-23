import 'package:flutter/foundation.dart';
import 'package:poc_app/application/di/data/auth_datasource.dart';
import 'package:poc_app/data/services/api_service.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final ApiService apiService;
  static String mainUrl = "https://reqres.in";

  const AuthDatasourceImpl({required this.apiService});

  @override
  Future<String> login(
      {required String email, required String password}) async {
    var loginUrl = '$mainUrl/api/login';

    try {
      var response = await apiService.post(url: loginUrl, bodyParams: {
        "email": email,
        "password": password,
      });

      String token = response['token'];

      return token;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("NewsDatasourceFromApi - fetchNewsList");
    }
  }
}
